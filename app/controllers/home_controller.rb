class HomeController < FrontendController
  def index
      @seo_carrier = OpenStruct.new description: @page.seo_descr,
                                       keywords: @page.seo_keywords
  end
end
