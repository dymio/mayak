class BaseImageUploader < BaseUploader

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  #   # process resize_to_fill: [100,100]
  #   # process resize_to_limit: [200,200]
  #   # process :grayscale
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Returns string like "#{width}x#{height}" or nil
  # def geom_sizes_string
  #   unless self.blank?
  #     image = MiniMagick::Image::open self.current_path
  #     "#{image[:width]}x#{image[:height]}"
  #   end
  # end

  # protected

  # def grayscale()
  #   manipulate! do |img|
  #     img.colorspace('Gray')
  #     img
  #   end
  # end

  # def is_landscape? picture
  #   image = MiniMagick::Image.open(picture.path)
  #   image[:width] > image[:height]
  # end

end
