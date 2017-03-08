require 'active_support'
require 'active_support/time'

ActiveSupport::TimeZone.all.each do |timezone|
  Time.zone = timezone.name

  every :day, :at => Time.zone.parse('0:00 am').utc do
    Rails.logger.info "0:00 am !!!"
    rake "image:remove_image[\"" + timezone.name + "\"]"
  end
end
