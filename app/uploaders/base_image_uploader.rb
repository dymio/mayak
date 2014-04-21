# -*- encoding : utf-8 -*-
class BaseImageUploader < BaseUploader

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  protected

  # def resize_if_bigger(of_width, of_height)
  #   manipulate! do |img|
  #     resize_string = ""
  #     if img[:width] > of_width
  #       resize_string += of_width.to_s
  #     end
  #     resize_string += "x"
  #     if img[:height] > of_height
  #       resize_string += of_height.to_s
  #     end
  #     img.resize(resize_string) unless resize_string == "x"
  #     img
  #   end
  # end

end
