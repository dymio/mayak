module Seo
  class Basic
    def initialize(seo_obj, no_postfix)
      @_no_postfix = no_postfix
      if seo_obj
        @_title = seo_obj.title if seo_obj.respond_to? :title
        if seo_obj.respond_to?(:seo_title) && seo_obj.seo_title.present?
          @_title = seo_obj.seo_title
        end
        
        @_description = seo_obj.seo_descr if seo_obj.respond_to? :seo_descr
        
        @_keywords = seo_obj.seo_keywords if seo_obj.respond_to? :seo_keywords

        @_image = seo_obj.seo_image if seo_obj.respond_to? :seo_image
        
        if seo_obj.respond_to?(:no_title_postfix) && seo_obj.no_title_postfix == '1'
          @_no_postfix = true
        end
      end
    end

    def title
      answ = nil
      if @_title.present?
        answ = @_title
        answ += " : " + SiteSetting.value_of('site_name') unless @_no_postfix
      else
        answ = SiteSetting.value_of('site_name')
      end
      answ
    end

    def description
      @_description
    end

    def keywords
      @_keywords
    end

    def image
      @_image
    end

    # author
    # reply_to

    # og:title
    # og:description
    # og:site_name
    # og:image

    # twitter:title
    # twitter:description
    # twitter:image

  end

  module Carrier
    def self.included(base)
      base.store :seodata, accessors: [ :no_title_postfix,
                                        :seo_title,
                                        :seo_descr,
                                        :seo_keywords ], coder: JSON

      base.attr_accessible :no_title_postfix,
                           :seo_title,
                           :seo_descr,
                           :seo_keywords
    end
  end
end

class << ActiveRecord::Base
  def acts_as_seo_carrier
    include Seo::Carrier
  end
end