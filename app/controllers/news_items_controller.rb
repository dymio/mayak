class NewsItemsController < FrontendController

  def index
    @news_items = NewsItem.find(:all)
    respond_to do |format|
      format.html
    end
  end

  def show
    @news_item = NewsItem.find_by_slug(params[:slug])
    respond_to do |format|
      format.html
    end
  end
  
end
