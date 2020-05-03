class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill(600, 600, gravity = ::Magick::CenterGravity)

  version :thumbnail70 do
    process resize_to_fit: [70, 70]
  end

  # def default_url(*args)
  #   "/images/" + [version_name, "default_thumbnail.png"].compact.join('_')
  # end

end
