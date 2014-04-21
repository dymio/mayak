# -*- encoding : utf-8 -*-
class MainNavItem < ActiveRecord::Base
  belongs_to :url_page, class_name: "ContentPage"

  attr_accessible :hided, :prior, :title, :url_page, :url_page_id, :url_text, :url_type

  validates :url_type, numericality: { only_integer: true }
  validates :url_type, inclusion: (0..1)
  validates :url_text, presence: true, :if => Proc.new { |a| a.url_type == 0 }
  validates :url_page, presence: true, :if => Proc.new { |a| a.url_type == 1 }
  validates :prior,    numericality: { only_integer: true }

  default_scope order('prior ASC')
  scope :visibles, where(hided: false)

  class << self
    def url_type_variants
      [['Произвольный текст ссылки', 0],['Ссылка на страницу', 1]]
    end
  end

  def name
    title
  end

  def inner_link?
    url_type == 1
  end

  def url
    if inner_link?
      url_page ? url_page.page_path : ""
    else
      url_text
    end
  end

  def url_type_humanized
    self.class.url_type_variants[url_type][0]
  end
end
