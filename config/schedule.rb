require 'active_support'
require 'active_support/time'

every :day, :at => '10:30 am' do
  run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  rake "image:remove_image"
end
