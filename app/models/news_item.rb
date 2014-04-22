class NewsItem < ActiveRecord::Base
  attr_accessible :content, :lead, :title, :slug
  validates_presence_of :content, :title
  validates_uniqueness_of :slug
  before_save :generate_slug
  before_save :generate_lead

  def find_by_slug slug
  	NewsItem.find(:first, :conditions => ['slug = ?', slug])
  end

private

  def generate_lead
  	if self.lead.blank?
	  	# there's no lead, so we try to find first paragraph of content 
	  	# http://stackoverflow.com/a/9661504
	  	self.lead = content[/#{Regexp.escape('<p>')}(.*?)#{Regexp.escape('</p>')}/m, 1]
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
