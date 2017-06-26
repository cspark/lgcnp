every :day, :at => '03:49am' do
  rake "image:remove_image"
end

every :day, :at => '08:39pm' do
  rake "image:remove_image"
end
