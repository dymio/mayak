module AdminHelper
  def static_file_image sf, show_name = false, version = nil
    if sf.image?
      image_tag(version ? sf.file.versions[version].url : sf.file.thumb.url)
    else
      [ "<span class=\"file-icon #{sf.filetype}\"></span>",
        (show_name ? " <b>#{sf.name}</b>" : "" ) ].join.html_safe
    end
  end
end
