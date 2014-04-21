class HomeController < FrontendController
  def index
      @seo_carrier = OpenStruct.new description: @page.description,
                                       keywords: @page.keywords
  end
end
