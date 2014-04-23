class NewsItemsController < FrontendController

  def index
    @news_items = NewsItem.where('hided = ?', false).order('published_at ASC').page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def show
    @news_item = NewsItem.find_by_slug(params[:slug], conditions: ['hided = ?', false])
    if @news_item.nil?
      not_found
    else
      respond_to do |format|
        format.html
      end
    end
  end

end
