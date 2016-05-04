class CategoryImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def default_url(*args)
    "/images/" + [version_name, 'default-category.svg'].compact.join('_')
  end

  def store_dir
    "uploads/images/#{model.id}"
  end

  def cache_dir
    "uploads/tmp/"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  version :thumb do
    process resize_to_fill: [318, 180]
  end

end
