# -*- encoding : utf-8 -*-
class SiteSetting < ActiveRecord::Base
  attr_accessible :descr, :hided, :ident, :name, :set_val, :val_type, :value

  # value types:
  #   nil || 0 --- string
  #          1 --- boolean  --- 'y' / 'n'
  #          2 --- number   --- number.to_s
  #          3 --- datetime --- (unix time).to_s
  #          4 --- content page --- content_page.id.to_s

  class << self
    def available_val_types
      [
        ["Строка", 0],
        ["Булево (да/нет)", 1],
        ["Число", 2],
        ["Дата и время", 3],
        ["Страница", 4]
      ]
    end

    def value_of(setting_ident)
      found_setting = self.find_by_ident(setting_ident)
      found_setting ? found_setting.value : nil
    end

    def set_value_for(setting_ident, new_value)
      success_flag = false
      if found_setting = self.find_by_ident(setting_ident)
        found_setting.value = new_value
        success_flag = found_setting.save
      end
      success_flag
    end
  end

  def value
    case self.val_type
    when 1 # boolean
      self.set_val == 'y' ? true : false
    when 2 # integer
      self.set_val.to_i
    when 3 # datetime
      self.set_val.present? ? Time.at(self.set_val.to_i) : nil
    when 4 # content page
      ContentPage.find_by_id self.set_val.to_i
    else # string
      self.set_val
    end
  end

  def value=(typed_value)
    self.set_val = case self.val_type
    when 1 # boolean
      typed_value && typed_value != "0" ? 'y' : 'n'
    when 3 # datetime
      typed_value.to_i.to_s
    when 4 # content_page
      typed_value && typed_value.is_a?(ContentPage) ? typed_value.id.to_s :
                                                      typed_value.to_s
    else # string and integer
      typed_value.to_s
    end
  end

  def humanized_value
    current_value = self.value
    case self.val_type
    when 1 # boolean
      current_value ? I18n.t('yep') : I18n.t('nope')
    when 2 # integer
      current_value.to_s
    when 3 # datetime
      current_value ? I18n.l(current_value, format: :long) : ""
    when 4 # content_page
      current_value ? current_value.title_with_parents : ""
    else # string
      current_value.to_s
    end
  end

  def humanized_value_type
    self.class.available_value_types[ (val_type.nil? ? 0 : val_type) ][0]
  end

end
