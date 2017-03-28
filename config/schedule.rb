require 'active_support'
require 'active_support/time'

ActiveSupport::TimeZone.all.each do |timezone|
  Time.zone = timezone.name
  every :day, :at => Time.zone.parse('12:00 pm').utc do
    rake "image:remove_image"
  end
  every :day, :at => Time.zone.parse('12:20 pm').utc do
    rake "image:remove_image"
  end
  # every :day, :at => Time.zone.parse('01:00 pm').utc do
  #   rake "image:remove_image"
  # end
end
