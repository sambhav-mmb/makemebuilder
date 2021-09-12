class TeamImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    @name ||= "#{model.name.parameterize}.#{file.extension}" if file
  end

  version :icon do
    process :resize_to_fit => [50, 50]
  end

  version :thumb do
    process :resize_to_fit => [200, 200]
  end

end