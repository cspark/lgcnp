# require 'active_support'
# require 'active_support/time'

# ActiveSupport::TimeZone.all.each do |timezone|
#   Time.zone = timezone.name
#   every :day, :at => Time.zone.parse('01:00 pm').utc do
#     rake "image:remove_image"
#   end
# end
# 01:00 pm -> 새벽 4시
# every :day, :at => '01:00 pm' do
#   rake "image:remove_image"
# end

every :day, :at => '07:50 am' do
  rake "image:remove_image"
end
