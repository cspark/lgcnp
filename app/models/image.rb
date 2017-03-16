class Image < ApplicationRecord
  attr_accessor :serial
  attr_accessor :ch_cd
  attr_accessor :measureno
  attr_accessor :type
  attr_accessor :number
  attr_accessor :sub_folder_name
  attr_accessor :private_folder_name
  attr_accessor :file_name

  mount_uploader :image, ImageUploader
end
