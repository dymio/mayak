class StaticFileUploader < BaseUploader

  include CarrierWave::MiniMagick

  version :thumb, if: :image? do
    process resize_to_fill: [32, 32]
  end

  version :big_thumb, if: :image? do
    process resize_to_fill: [96, 96]
  end

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

end
