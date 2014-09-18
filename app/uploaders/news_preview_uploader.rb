class NewsPreviewUploader < BaseImageUploader

  # Twitter summary card minimal size
  process resize_to_fill: [280, 150]

end
