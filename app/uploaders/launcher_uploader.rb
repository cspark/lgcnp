class LauncherUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "/Admin/Update/"
  end

   def filename
     "#{@@file_name}.#{@@file_extension}"
   end

   def temp_save_update_launcher(file_name: nil)
     @@file_name = file_name
     @@file_extension = ".zip"
   end
end
