class Page < ActiveRecord::Base

  acts_as_seo_carrier
  acts_as_static_files_holder

  validates :path, presence: true, unless: Proc.new { |a| a.home? }
  validates :prior, numericality: { only_integer: true }

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

  private

  def prepare_path
    self.path = UrlStringPreparator.path self.path, self.title unless self.home?
  end

  def check_destroying_possibility
    errors.add :base, "Нельзя удалить зафиксированную страницу" if self.fixed?
    errors.add :base, "Нельзя удалить главную страницу" if self.home?
    errors.blank?
  end

end
