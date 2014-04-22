class NewsItem < ActiveRecord::Base
  attr_accessible :content, :lead, :title
  validates_presence_of :content, :title
end
