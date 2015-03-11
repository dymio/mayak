class PagesController < FrontendController
  def show
    if @page.nil?
      raise ActiveRecord::RecordNotFound, "Record not found"
    else
      respond_to do |format|
        format.html
        # format.json  { render json: @page }
      end
    end
  end
end
