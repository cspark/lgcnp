require 'active_support'
require 'active_support/time'

every :day, :at => '10:30 am' do
  rake "image:remove_image"
end
