# frozen_string_literal: true

class ImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    save_directory = "#{Rails.env}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # オリジナル画像を横幅400pxに制限して保存する。
  process resize_to_fill(400, 400, gravity = ::Magick::CenterGravity)

  # Create different versions of your uploaded files:

  version :profile90 do
    process resize_to_fit: [90, 90]
  end

  version :profile100 do
    process resize_to_fit: [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def default_url(*_args)
    '/images/' + [version_name, 'default.png'].compact.join('_')
  end
end
