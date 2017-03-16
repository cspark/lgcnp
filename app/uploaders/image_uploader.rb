class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{model.ch_cd}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   def filename
     "#{original_filename}.#{file.extension}" if original_filename.present?
   end

   process :fix_exif_rotation

   def fix_exif_rotation
     manipulate! do |img|
       img.tap(&:auto_orient)
     end
   end

   protected
   def secure_token
     var = :"@#{mounted_as}_secure_token"
     model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
   end
end
