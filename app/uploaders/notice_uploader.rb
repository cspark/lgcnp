class NoticeUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "Admin/Notice"
  end

   def filename
     "#{@@filename}.#{@@file_extension}"
   end

   def temp_save_update_launcher(filename: nil)
     @@filename = filename
     @@file_extension = "zip"
   end
end
