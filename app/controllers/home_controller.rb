class HomeController < FrontendController
  def index
    @seo_carrier = OpenStruct.new seo_descr: @page.seo_descr,
                                  seo_keywords: @page.seo_keywords
  end
end
