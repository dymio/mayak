class NewsPreviewUploader < BaseImageUploader

  process resize_to_fill: [280, 150]

end
