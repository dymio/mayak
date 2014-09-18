# Prepare string for using as slug.
# Russian version (can transliterate russian chars).
#   requires gem 'russian'

class SlugPreparatorRus
  def self.slug(str, fallback)
    str = fallback.to_s if str.blank?
    Russian::transliterate(str).parameterize.dasherize
  end
end
