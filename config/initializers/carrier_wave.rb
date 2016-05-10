require 'carrierwave/orm/activerecord'
CarrierWave.configure do |config|

#  config.fog_public     = false # optional, defaults to true
  if Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS', # required
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'], # required
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'], # required
  #    :host                   => 's3.example.com', # optional, defaults to nil
  #    :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME'] # required

    config.storage :fog
    #config.root = Rails.root.join('tmp')
    #config.cache_dir = 'uploads'
  else
    config.storage :file
  end
  config.cache_dir = "#{Rails.root}/tmp/uploads"
#  config.s3_access_policy = :public_read
#  config.fog_host = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"
#  config.fog_attributes = { 'Cache-Control' => 'max-age=#{365.say.to_i}' }
end
