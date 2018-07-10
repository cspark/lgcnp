every :day, :at => '01:05am' do
  rake "custinfo_lcareuser:sync"
end

every :day, :at => '03:49am' do
  rake "image:remove_image"
end

every :day, :at => '08:59pm' do
  rake "image:remove_image"
end
