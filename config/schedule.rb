require 'active_support'
require 'active_support/time'

ActiveSupport::TimeZone.all.each do |timezone|
  Time.zone = timezone.name
  # Rails.logger.info Time.zone
  # Rails.logger.info Time.zone.parse('02:30 am').utc
  every :day, :at => Time.zone.parse('02:30 am').utc do
    rake "image:remove_image"
  end
  every :day, :at => Time.zone.parse('02:40 am').utc do
    rake "image:remove_image"
  end
  # every :day, :at => Time.zone.parse('01:00 pm').utc do
  #   rake "image:remove_image"
  # end
end
