class Setting < ActiveRecord::Base

  # stored fields: :ident, :name, :descr, :vtype, :val, :group, :often, :hidden

  # Value types constants
  VTYPE_STRING    = 0
  VTYPE_BOOLEAN   = 1
  VTYPE_NUMBER    = 2
  VTYPE_DATETIME  = 3
  VTYPE_TEXT      = 4
  VTYPE_MAP_POINT = 5
  VTYPE_PAGE      = 6

  validates :ident, presence: true

  after_save :reload_provider, if: :often?

  scope :visibles, -> { where(hidden: false) }
  scope :ordered, -> { order(id: :asc) }

  # AtiveAdmin displayed name
  def display_name; name end

  def value
    case self.vtype
    when VTYPE_BOOLEAN
      self.val == 'y' ? true : false
    when VTYPE_NUMBER
      self.val.to_f
    when VTYPE_DATETIME
      self.val.present? ? Time.at(self.val.to_i) : nil
    # when VTYPE_PAGE # TODO
    #   Page.find_by_id self.val.to_i
    else
      self.val # string, text and map point
    end
  end

  def value=(typed_value)
    self.val = case self.vtype
               when VTYPE_BOOLEAN
                 typed_value && typed_value != "0" ? 'y' : 'n'
               when VTYPE_DATETIME
                 typed_value.to_i.to_s
               # when VTYPE_PAGE # TODO
               #   typed_value && typed_value.is_a?(Page) ?
               #     typed_value.id.to_s :
               #     typed_value.to_s
               else
                 typed_value.to_s # string, number, text and map point
               end
  end

  def humanized_value
    current_value = self.value
    case self.vtype
    when VTYPE_BOOLEAN
      current_value ? I18n.t('yep') : I18n.t('nope')
    when VTYPE_NUMBER
      current_value.to_s
    when VTYPE_DATETIME
      current_value ? I18n.l(current_value, format: :long) : ""
    # when VTYPE_MAP_POINT
    #   # TODO show image_tag with static map picture in html_safe
    # when VTYPE_PAGE # TODO
    #   current_value ? current_value.title_with_parents : ""
    else
      current_value.to_s # string and text
    end
  end

  # Hack formtastic type determiner
  def column_for_attribute(method)
    if method.to_s == "value" && [VTYPE_BOOLEAN,
                                  VTYPE_NUMBER,
                                  VTYPE_DATETIME,
                                  VTYPE_PAGE].include?(self.vtype)
      dressed_like_column = OpenStruct.new(
        name: "value", type: nil, sql_type: nil, klass: nil,
        coder: nil, default: false, null: true, primary: false,
        limit: nil, precision: nil, scale: nil
      )
      case self.vtype
      when VTYPE_BOOLEAN
        dressed_like_column.type = :boolean
        dressed_like_column.sql_type = "boolean"
        dressed_like_column.klass = Object
      when VTYPE_NUMBER
        dressed_like_column.type = :decimal
        dressed_like_column.sql_type = "numeric"
        dressed_like_column.klass = BigDecimal
      when VTYPE_DATETIME
        dressed_like_column.type = :datetime
        dressed_like_column.sql_type = "timestamp without time zone"
        dressed_like_column.klass = Time
      # when VTYPE_PAGE # TODO
      #   dressed_like_column.type = :page
      #   dressed_like_column.sql_type = "page"
      #   dressed_like_column.klass = Page
      end
      dressed_like_column
    else
      super(method)
    end
  end

  private

  def reload_provider
    SettingProvider.instance.reload_aggregator!
  end
end


# Settings provider allows you get and set settings
class SettingProvider
  include Singleton

  def value_of(setting_ident)
    if check_aggregator(setting_ident)
      # get value from aggregator
      aggregated_value(setting_ident)
    else
      #  ask database if aggregator isn't include this setting value
      found_setting = Setting.find_by_ident(setting_ident) unless found_setting
      found_setting ? found_setting.value : nil
    end
  end

  def set_value_for(setting_ident, new_value)
    success_flag = false
    if found_setting = Setting.find_by_ident(setting_ident)
      found_setting.value = new_value
      success_flag = found_setting.save
    end
    success_flag
  end

  def reload_aggregator!
    fill_aggregator
  end

  private

  def aggregated_value(setting_ident)
    return nil unless @aggregator
    @aggregator[setting_ident.to_s]
  end

  # Aggregator includes preloaded values with 'often' attruibute == `true`
  def check_aggregator(setting_ident)
    fill_aggregator unless @aggregator
    @aggregator.has_key? setting_ident.to_s
  end

  # Fill aggregator with first request to any setting value
  def fill_aggregator
    @aggregator = {}
    Setting.where(often: true).each do |sset|
      @aggregator[sset.ident] = sset.value
    end
  end
end
