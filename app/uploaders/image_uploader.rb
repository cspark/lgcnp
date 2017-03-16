class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{model.ch_cd}/#{model.sub_folder_name}/#{model.private_folder_name}"
  end

   def filename
     "#{file_name}.#{file.extension}"
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
