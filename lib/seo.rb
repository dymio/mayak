module Seo
  class Basic
    def initialize(seo_carr_obj, no_postfix)
      if seo_carr_obj
        if seo_carr_obj.respond_to? :title
          @_title = seo_carr_obj.title
        end
        if seo_carr_obj.respond_to? :description
          unless seo_carr_obj.description == ""
            @_description = seo_carr_obj.description
          end
        end
        if seo_carr_obj.respond_to? :keywords
          unless seo_carr_obj.keywords == ""
            @_keywords = seo_carr_obj.keywords
          end
        end
      end
      @_no_postfix = no_postfix
    end

    def title
      answ = nil
      if @_title.present?
        answ = @_title
        unless @_no_postfix
          answ += " :: " + SiteSetting.value_of('default_page_title')
        end
      else
        answ = SiteSetting.value_of('default_page_title')
      end
      answ
    end

    def description
      @_description || SiteSetting.value_of('default_page_description')
    end

    def keywords
      @_keywords || SiteSetting.value_of('default_page_keywords')
    end

    # author
    # reply_to
    # image

    # og:title
    # og:description
    # og:site_name
    # og:image

    # twitter:title
    # twitter:description
    # twitter:image

  end
end