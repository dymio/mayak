class News < ActiveRecord::Base

  # stored fields: :title, :slug, :published_at, :preview,
  #                :intro, :body, :seodata, :hided

  has_many :static_files, as: :holder, dependent: :destroy

  acts_as_seo_carrier

  mount_uploader :preview, NewsPreviewUploader

  validates :title, :published_at, presence: true
  validates :slug, uniqueness: true

  after_initialize :set_defaults
  before_validation :prepare_slug
  after_create :set_static_files_holder

  scope :visibles, -> { where("news.published_at < ?", Date.tomorrow.to_time).
                        where(hided: false) }
  scope :ordered, -> { order(published_at: :desc, id: :desc) }

  def display_name; title end

  def seo_image; preview.url end

  private

  def set_defaults
    self.published_at = Time.now if self.published_at.nil?
  end

  def prepare_slug
    self.slug = SlugPreparatorRus.slug self.slug, self.title
  end

  def set_static_files_holder
    # TODO use this not only for body (collection of html text fields)
    if self.body.present?
      # TODO get store_dir from StaticFileUploader
      sf_ids = self.body.scan(/\/uploads\/static_file\/file\/([0-9]+)/)
                        .collect { |ida| ida[0].to_i }
      sfs = StaticFile.holderless.where id: sf_ids
      sfs.each do |sf|
        sf.holder = self
        sf.save
      end
    end
  end

end
