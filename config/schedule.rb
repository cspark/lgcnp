# 01:00 pm -> 새벽 4시

every :day, :at => '05:00pm' do
  rake "image:remove_image"
end

every :day, :at => '02:00am' do
  rake "image:slack_test"
end
