# -*- encoding : utf-8 -*-
class ContentPageValidator < ActiveModel::Validator
  def validate(page)
    # Homepage can't be a parent
    if page.parent.present? && page.parent.home?
      page.errors[:parent_id] << "Нельзя указывать Главную как родительскую страницу"
    end

    unless page.new_record?
      # Can't make page with children a homepage
      if page.home? && page.has_children?
        page.errors[:parent_id] << "У Главной страницы не может быть дочерних страниц"
      end

      # Can't use redirect to first children without any children
      if page.behavior_type == 1 && page.is_childless?
        page.errors[:behavior_type] << "Нельзя указывать данный тип редиректа, когда нет дочерних страниц"
      end
    end

    # Homepage must be slugless
    if page.home? && page.slug.present?
      page.errors[:slug] << "Для Главной страницы SLUG должен быть пустой"
    end

    # Slug must be uniq between siblings
    if page.has_siblings?
      has_slug_match = false
      page.siblings.select { |sl| sl != page }.each do |slpage|
        if page.slug == slpage.slug
          page.errors[:slug] << "SLUG должен быть уникален на одном уровне страниц"
        end
      end
    end
  end
end

class ContentPage < ActiveRecord::Base
  belongs_to :rct_page, class_name: "ContentPage"

  has_ancestry

  attr_accessible :title, :slug, :immortal, :parent, :parent_id,
                  :behavior_type, :rct_page, :rct_page_id, :rct_lnk,
                  :body, :description, :keywords, :hided, :prior

  validates :slug, presence: true, :unless => Proc.new { |a| a.home? }
  validates :prior, numericality: { only_integer: true }
  validates :behavior_type,  numericality: { only_integer: true }
  validates :behavior_type,  inclusion: (0..3)
  validates :rct_page, presence: true, :if => Proc.new { |a| a.behavior_type == 2 }
  validates :rct_lnk,  presence: true, :if => Proc.new { |a| a.behavior_type == 3 }
  validates_with ContentPageValidator

  before_validation :make_auto_slug
  before_destroy    :check_destroying_possibility

  scope :by_prior, order("content_pages.prior ASC, content_pages.id ASC")
  scope :visibles, where(hided: false)
  scope :without_ids, lambda {|idsa| where("content_pages.id NOT IN (?)", idsa) }

  class << self
    def homepage
      sres = self.where(ancestry: nil, slug: "").limit(1)
      sres.any? ? sres[0] : nil
    end

    def behavior_type_variants
      [['Страница', 0],['Редирект на первую дочернюю страницу', 1],
       ['Редирект на произвольную страницу', 2], ['Редирект по указанной ссылке', 3]]
    end

    # Try to find the content page by page path
    # page_path must be without "/" at the start and without http parameters
    #   example: about/news/news-post-12.html
    def find_by_path(page_path)
      path_parts = page_path.split("/")
      step_page = nil
      step = 0

      if page_path == ""
        # Try to find homepage
        page_search = self.roots.where(slug: "")
        step_page = page_search[0] if page_search.any?
      end

      while step < path_parts.length do
        path_part = path_parts[step]
        page_search = step_page.nil? ? self.roots : step_page.children
        page_search = page_search.where(slug: path_part)
        if page_search.any?
          step_page = page_search[0]
        else
          stop_it = true
          if step == (path_parts.length - 1) # last element
            # try to remove extention and try again (if has extention)
            if ext_match = path_part.match(/(.*)\.\w*$/)
              path_parts[step] = ext_match[1]
              step -= 1
              stop_it = false
            end
          end
          if stop_it
            step_page = nil
            step = path_parts.length
          end
        end
        step += 1
      end

      step_page
    end
  end

  def name
    title
  end

  def title_with_parents
    path.collect {|node| node.title }.join " / "
  end

  def home?
    root? && slug.blank? && (!new_record? || self.class.count == 0)
  end

  def redirector?
    (1..3).include? behavior_type
  end

  def behavior_type_humanized
    self.class.behavior_type_variants[behavior_type][0]
  end

  def full_slug
    path.collect {|node| node.slug }.join "/"
  end

  def page_path
    answer = full_slug
    answer = "/" + answer unless answer[0] == "/"
    answer
  end

  private

  def make_auto_slug
    if self.slug.blank? && !self.home?
      self.slug = Russian::transliterate(self.title).
        downcase.
        gsub(/[^a-z0-9]/, '-'). # change all incorrect symbols to '-'
        gsub(/[-]{2,}/,'-').    # remove all several '-' in line
        gsub(/^[-]+/,'').       # remove all '-' from start of string
        gsub(/[-]+$/, '')       # remove all '-' from end of string
    end
  end

  def check_destroying_possibility
    errors.add :base, "Нельзя удалить базовую страницу" if self.immortal?
    errors.add :base, "Нельзя удалить главную страницу" if self.home?
    errors.blank?
  end
end
