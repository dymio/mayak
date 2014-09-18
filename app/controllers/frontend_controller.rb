class FrontendController < ApplicationController

  before_filter :determine_page #, :collect_main_nav_items

  protected

  def determine_page
    @page = nil
    # TODO
    # # try to find page for current url
    # if path_match = request.fullpath.match(/\/?([^\?]*)\??/)
    #   @page = ContentPage.find_by_path path_match[1]
    # end
    @seo_carrier = @page
  end

  def seo
    @seo ||= Seo::Basic.new @seo_carrier, false
  end

  helper_method :seo

  private

  # TODO collect_main_nav_items
  # def collect_main_nav_items
  #   @main_nav_items = MainNavItem.visibles
    
  #   @active_main_nav_item = nil
  #   @main_nav_items.each do |mni|
  #     if /^#{mni.url}/.match request.path
  #       if @active_main_nav_item
  #         if mni.url.length > @active_main_nav_item.url.length
  #           @active_main_nav_item = mni
  #         end
  #       else
  #         @active_main_nav_item = mni
  #       end
  #     end
  #   end
  # end
end
