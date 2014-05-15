class SlugPreparatorRus
  def self.slug(str, fallback)
    str = fallback.to_s if str.blank?
    Russian::transliterate(str).
      downcase.
      gsub(/[^a-z0-9]/, '-'). # change all incorrect symbols to '-'
      gsub(/[-]{2,}/,'-').    # remove all several '-' in line
      gsub(/^[-]+/,'').       # remove all '-' from start of string
      gsub(/[-]+$/, '')       # remove all '-' from end of string
  end
end
