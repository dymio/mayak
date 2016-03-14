# Prepare string for using as slug or path.
# Has russian version (can transliterate russian chars). requires gem 'russian'

class UrlStringPreparator
  def self.slug(str, fallback)
    str = fallback.to_s if str.blank?
    prepare_part(str)
  end

  def self.path(str, fallback)
    str = fallback.to_s if str.blank?
    str.split('/')
       .reject {|pps| pps.empty? }
       .map { |pps| prepare_part(pps) }
       .join('/')
  end

  def self.prepare_part(str)
    str = Russian::transliterate(str) if I18n.locale == :ru
    str = str.parameterize.dasherize
    str = '-' if str.blank?
    str
  end

  private_class_method :prepare_part
end
