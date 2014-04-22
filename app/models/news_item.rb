class NewsItem < ActiveRecord::Base
  attr_accessible :body, :lead, :title, :slug, :hided
  validates_presence_of :body, :title
  validates_uniqueness_of :slug
  before_save :generate_slug
  before_save :generate_lead

private

  def generate_lead
    if self.lead.blank?
      # there's no lead, so we try to find first paragraph of body 
      # http://stackoverflow.com/a/9661504
      self.lead = body[/#{Regexp.escape('<p>')}(.*?)#{Regexp.escape('</p>')}/m, 1]
    end
  end

  def generate_slug
    if self.slug.blank?
      self.slug = Russian::transliterate(self.title).
        downcase.
        gsub(/[^a-z0-9]/, '-'). # change all incorrect symbols to '-'
        gsub(/[-]{2,}/,'-').    # remove all several '-' in line
        gsub(/^[-]+/,'').       # remove all '-' from start of string
        gsub(/[-]+$/, '')       # remove all '-' from end of string
    end
  end

end
