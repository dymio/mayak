class FrontendController < ApplicationController

  before_filter :determine_page, :collect_nav_items

  protected

  def setting_value(setting_name)
    SettingProvider.instance.value_of setting_name
  end

  def determine_page
    @page = nil
    # try to find page for current url
    if path_match = request.fullpath.match(/\/?([^\?]*)\??/)
      @page = Page.find_by_path path_match[1]
    end
    @seo_carrier = @page
  end

  def seo
    @seo ||= Seo::Basic.new @seo_carrier, false, setting_value('site_name')
  end

  helper_method :setting_value, :seo

  private

  def collect_nav_items
    @nav_items = NavItem.visibles
    @active_nav_item = nil
    @nav_items.each do |ni|
      if /^#{ni.url}/.match request.path
        if @active_nav_item
          @active_nav_item = ni if ni.url.length > @active_nav_item.url.length
        else
          @active_nav_item = ni
        end
      end
    end
  end
end
