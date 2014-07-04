# -*- encoding : utf-8 -*-
class StaticFile < ActiveRecord::Base
  mount_uploader :file, StaticFileUploader

  attr_accessible :file

  validates :file, presence: true

  # For ActiveAdmin interface
  def name
    self.class.model_name.human + " #" + id.to_s
  end

  def file_name
    file.url.split('/')[-1]
  end

  def file_ext
    file.url.split('.')[-1]
  end

  def image_here?
    %w(png bmp jpg jpeg gif).include? file_ext.downcase
  end
end
