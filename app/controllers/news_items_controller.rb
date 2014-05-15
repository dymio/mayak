# -*- encoding : utf-8 -*-
class NewsItemsController < FrontendController
  def index
    @seo_carrier ||= OpenStruct.new(title: I18n.t('defaults.news_page_title'))
    @news_items = NewsItem.where('hided = ?', false).order('published_at ASC').page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def show
    @news_item = NewsItem.find_by_slug! params[:slug] #, conditions: ['hided = ?', false]
    @seo_carrier = @news_item
    respond_to do |format|
      format.html
    end
  end

end
