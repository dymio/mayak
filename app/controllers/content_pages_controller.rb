class ContentPagesController < FrontendController
  def show
    if @page.nil?
      not_found
    else
      if @page.redirector?
        # Redirection
        redirect_url = root_url # by default

        case @page.behavior_type
        when 1
          if @page.has_children?
            redirect_url = @page.children.by_prior.first.page_path
          end
        when 2
          redirect_url = @page.rct_page.page_path if @page.rct_page.present?
        when 3
          redirect_url = @page.rct_lnk if @page.rct_lnk.present?
        end

        redirect_to redirect_url, status: 302
      else
        @page.path.each {|pcp| add_breadcrumb(pcp.title, pcp.page_path) }
        respond_to do |format|
          format.html
          # format.json  { render :json => @page }
        end
      end
    end
  end
end
