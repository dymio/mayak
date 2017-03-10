class Page < ActiveRecord::Base

  acts_as_seo_carrier
  acts_as_static_files_holder

  validates :path, presence: true, unless: Proc.new { |a| a.home? }
  validates :prior, numericality: { only_integer: true }
  validate :fixed_page_visible_and_path_not_changed

  before_validation :prepare_path
  before_destroy    :check_destroying_possibility

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc, id: :asc) }
  scope :without_ids, ->(idsarr) { where.not(id: idsarr) }

  # ActiveAdmin displayed name
  def display_name; title end

  def home?
    path.blank? && (!new_record? || self.class.count == 0)
  end

  def fixed?
    return false if self.new_record?
    path_is_fixed? path_was
  end

  def will_be_fixed_after_save?
    path_is_fixed? path
  end

  private

  def path_is_fixed?(check_path)
    Rails.application.config.fixed_pages_paths.include? check_path
  end

  # before validation
  def prepare_path
    self.path = UrlStringPreparator.path self.path, self.title unless self.home?
  end

  # validation
  def fixed_page_visible_and_path_not_changed
    # fixed pages always persisted
    if path_changed? && fixed?
      errors.add(:path, "Нельзя менять URL‐путь зафиксированной страницы")
    end

    if will_be_fixed_after_save? && hided?
      errors.add(:hided, "Зафиксированная страница не может быть скрыта")
    end
  end

  # before destroy
  def check_destroying_possibility
    errors.add :base, "Нельзя удалить зафиксированную страницу" if self.fixed?
    errors.add :base, "Нельзя удалить главную страницу" if self.home?
    errors.blank?
  end

end
