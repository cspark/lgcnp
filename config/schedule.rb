require 'active_support'
require 'active_support/time'

every :day, :at => '7:25 pm' do
  command "mkdir public/TEST"
  system("mkdir public/TEST2")
  rake "image:remove_image"
end
