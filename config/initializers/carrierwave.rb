if Rails.env.production?

  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        
    config.fog_credentials = {
      provider:              'AWS',                        
      aws_access_key_id:     ENV["S3_ACCESS_KEY"],        
      aws_secret_access_key: ENV["S3_SECRET_KEY"],
    }
    config.fog_directory  = ENV["S3_BUCKET"]              
  end

    config.fog_directory  = ENV['AWS_BUCKET_NAME'] # required
    config.fog_public     = false  
    config.storage        = :fog   
    config.fog_attributes = { :cache_control => 'max-age=315576000', :expires => 1.year.from_now.httpdate }
    # see https://github.com/jnicklas/carrierwave#using-amazon-s3
    # for more optional configuration
  # end
end
