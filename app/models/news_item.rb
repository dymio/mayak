class NewsItem < ActiveRecord::Base
  attr_accessible :body, :lead, :title, :slug, :hided,
    :description, :keywords, :date

  validates_presence_of :body, :title
  validates_uniqueness_of :slug
  before_save :default_values

private

  def default_values

    if self.date.blank?
      self.date = self.created_at
    end

    if self.hided.blank?
      self.hided = false
    end

    if self.lead.blank?
      # there's no lead, so we try to find first paragraph of body 
      # http://stackoverflow.com/a/9661504
      self.lead = body[/#{Regexp.escape('<p>')}(.*?)#{Regexp.escape('</p>')}/m, 1]
    end
    
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
