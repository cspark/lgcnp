# 01:00 pm -> 새벽 4시

every :day, :at => '03:49am' do
  rake "image:remove_image"
end

every :day, :at => '08:59pm' do
  rake "image:remove_image"
end
