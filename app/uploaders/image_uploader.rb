class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{@@image_ch_cd}/#{@@sub_folder_name}/#{@@private_folder_name}"
  end

   def filename
     "#{@@file_name}.#{@@file_extension}"
   end

   def self.temp_save(file_name: nil, file_extension: nil, image_ch_cd: nil, sub_folder_name: nil, private_folder_name: nil)
     @@file_name = file_name
     @@file_extension = file_extension
     @@image_ch_cd = image_ch_cd
     @@sub_folder_name = sub_folder_name
     @@private_folder_name = private_folder_name
   end
end
