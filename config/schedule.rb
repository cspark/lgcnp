require 'active_support'
require 'active_support/time'

every :day, :at => '4:00 am' do
  rake "image:remove_image"
end
