class News < ActiveRecord::Base

  acts_as_seo_carrier
  acts_as_static_files_holder

  mount_uploader :preview, NewsPreviewUploader

  validates :title, :published_at, presence: true
  validates :slug, uniqueness: true

  after_initialize :set_defaults
  before_validation :prepare_slug

  scope :visibles, -> { where("news.published_at < ?", Time.now).
                        where(hided: false) }
  scope :ordered, -> { order(published_at: :desc, id: :desc) }

  def display_name; title end

  def seo_image; preview.url end

  private

  def set_defaults
    self.published_at = Time.now if self.published_at.nil?
  end

  def prepare_slug
    self.slug = UrlStringPreparator.slug self.slug, self.title
  end

end
