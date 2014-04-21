# encoding: utf-8
class StaticFileUploader < BaseUploader
  
  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

end
