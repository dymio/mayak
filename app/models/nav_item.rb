class NavItem < ActiveRecord::Base

  belongs_to :url_page, class_name: "Page"

  validates :title,    presence: true
  validates :url_type, numericality: { only_integer: true }
  validates :url_type, inclusion: (0..1)
  validates :url_text, presence: true, if: Proc.new { |ni| ni.url_type == 0 }
  validates :url_page, presence: true, if: Proc.new { |ni| ni.url_type == 1 }
  validates :prior,    numericality: { only_integer: true }

  default_scope { order(prior: :asc) }
  scope :visibles, -> { where(hided: false) }

  def self.url_type_variants
    [['Произвольный текст ссылки', 0],['Ссылка на страницу', 1]]
  end

  # ActiveAdmin displayed name
  def display_name; title end

  def inner_link?
    url_type == 1
  end

  def url
    if inner_link?
      url_page ? "/#{url_page.path}" : ""
    else
      url_text
    end
  end

  def url_type_humanized
    self.class.url_type_variants[url_type][0]
  end

end
