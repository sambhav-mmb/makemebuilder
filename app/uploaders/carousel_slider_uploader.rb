class CarouselSliderUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :icon do
    process :resize_to_fit => [50, 50]
  end

  version :thumb do
    process :resize_to_fit => [200, 200]
  end

  version :slide do
    process :resize_to_fit => [400, 400]
  end

end