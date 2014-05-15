class NewsItem < ActiveRecord::Base
  acts_as_seo_carrier
  
  attr_accessible :body, :lead, :title, :slug, :hided, :published_at

  validates_presence_of :body, :title, :published_at
  validates_uniqueness_of :slug
  before_save :default_values

  private

  def default_values
    if self.published_at.blank?
      self.published_at = Date.today
    end

    if self.hided.blank?
      self.hided = false
    end

    if self.lead.blank?
      # there's no lead, so we try to find first paragraph of body 
      # http://stackoverflow.com/a/9661504
      self.lead = body[/#{Regexp.escape('<p>')}(.*?)#{Regexp.escape('</p>')}/m, 1]
      self.lead ||= ""
    end
    
    self.slug = SlugPreparatorRus.slug self.slug, self.title
  end

end
