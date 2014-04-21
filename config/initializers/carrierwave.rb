# -*- encoding : utf-8 -*-
CarrierWave.configure do |config|

  # if Rails.env.production?
  #   config.storage = :fog
  #   config.fog_credentials = {
  #     :provider               => 'AWS',
  #     :aws_access_key_id      => 'xxx',
  #     :aws_secret_access_key  => 'xxx/xxx/K',
  #     :region                 => 'us-east-1'
  #   }

  #   config.fog_directory  = 'xxxxxx-bucket' # required
  #   config.asset_host     = nil             # optional, def is nil
  #   config.fog_public     = true            # optional, def is true
  #   config.fog_attributes = {}              # optional, def is {}
  # else

    config.storage = :file
    config.permissions = 0666
    config.directory_permissions = 0777
    # config.store_dir = "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"

  # end

  # config.cache_dir = Rails.root.join("tmp/#{store_dir}")
end
