require 'active_support'
require 'active_support/time'

ActiveSupport::TimeZone.all.each do |timezone|
  Time.zone = timezone.name

  every :day, :at => Time.zone.parse('11:10 am').utc do
    rake "image:remove_image"
  end
end
