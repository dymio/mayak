class News < ActiveRecord::Base
  acts_as_seo_carrier
  
  attr_accessible :body, :lead, :title, :slug, :hided, :published_at

  validates_presence_of :body, :title, :published_at
  validates_uniqueness_of :slug

  after_initialize :set_defaults
  before_save :default_values

  scope :visibles, where("news.published_at < TIMESTAMP 'tomorrow'").
                   where(hided: false)
  scope :ordered, order('news.published_at DESC, news.id DESC')

  private

  def set_defaults
    self.published_at = Date.today if self.published_at.nil?
  end

  def default_values
    if self.lead.blank?
      # there's no lead, so we try to find first paragraph of body 
      # http://stackoverflow.com/a/9661504
      self.lead = body[/#{Regexp.escape('<p>')}(.*?)#{Regexp.escape('</p>')}/m, 1]
      self.lead ||= ""
    end
    
    self.slug = SlugPreparatorRus.slug self.slug, self.title
  end

end
