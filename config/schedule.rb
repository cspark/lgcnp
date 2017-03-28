require 'active_support'
require 'active_support/time'

# ActiveSupport::TimeZone.all.each do |timezone|
#   Time.zone = timezone.name
  # every :day, :at => Time.zone.parse('01:00 pm').utc do
  #   rake "image:remove_image"
  # end
# end

every :day, :at => '1:10 am' do
  system("rm -rf public/BEAU")
  system("rm -rf public/CNP")
  system("rm -rf public/CLAB")
  system("rm -rf public/LABO")
  system("rm -rf public/MART")
  system("rm -rf public/TMR")

  system("mkdir public/BEAU")
  system("mkdir public/CNP")
  system("mkdir public/CLAB")
  system("mkdir public/LABO")
  system("mkdir public/MART")
  system("mkdir public/TMR")
end
