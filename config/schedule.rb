require 'active_support'
require 'active_support/time'


every 1.day, :at => '1:00 pm' do
  command "mkdir public/TEST"
end
