require 'active_support'
require 'active_support/time'

every :day, :at => '4:00 am' do
  system("rm -rf public/BEAU")
  system("rm -rf public/CNP")
  system("rm -rf public/CLAB")
  system("rm -rf public/LABO")
  system("rm -rf public/MART")
  system("rm -rf public/TMR")
  # rake "image:remove_image"
end
