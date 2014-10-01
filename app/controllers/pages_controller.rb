class PagesController < FrontendController
  def show
    if @page.nil?
      not_found
    else
      respond_to do |format|
        format.html
        # format.json  { render :json => @page }
      end
    end
  end
end
