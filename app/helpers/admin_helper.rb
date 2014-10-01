module AdminHelper
  def static_file_image sf, show_name = false, image_size = nil
    if sf.filetype == "img"
      image_tag sf.file.url, size: (image_size || "32x32")
    else
      [ "<span class=\"file-icon #{sf.filetype}\"></span>",
        (show_name ? " <b>#{sf.name}</b>" : "" ) ].join.html_safe
    end
  end
end
