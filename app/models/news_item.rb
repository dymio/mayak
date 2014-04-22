class NewsItem < ActiveRecord::Base
  attr_accessible :content, :lead, :title, :slug
  validates_presence_of :content, :title
  validates_uniqueness_of :slug
  before_save :generate_slug

  def generate_slug
  	slug ||= make_auto_slug
  end

  def make_auto_slug
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
