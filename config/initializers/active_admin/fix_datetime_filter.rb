# Fix datetime filter bug when you choose one date in from and to field
#  and do not get results includes in this day
# based on https://github.com/inossidabile/mastering_aa/blob/master/config/initializers/active_admin/fix_resource_controller.rb
ActiveAdmin::ResourceController.class_eval do
  before_filter :fix_datetime_filter_inclusion, only: :index

private

  def fix_datetime_filter_inclusion
    resource_class.columns.each do |c|
      next unless c.type == :datetime

      if !params["q"].blank? && !params["q"]["#{c.name}_lteq"].blank?
        params["q"]["#{c.name}_lteq"] += " 23:59:59.999999"
      end
    end
  end
end