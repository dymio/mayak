# -*- encoding : utf-8 -*-
class NewsController < FrontendController
  def index
    @seo_carrier ||= OpenStruct.new(title: I18n.t('defaults.news_page_title'))
    @news = News.visibles.ordered.page params[:page]
    respond_to do |format|
      format.html
    end
  end

  def show
    @news = News.find_by_slug! params[:id] #, conditions: ['hided = ?', false]
    @seo_carrier = @news
    respond_to do |format|
      format.html
    end
  end

end
