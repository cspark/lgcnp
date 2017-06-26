every :day, :at => '03:49am' do
  rake "image:remove_image"
end

every :day, :at => '06:59pm' do
  rake "image:remove_image"
end
