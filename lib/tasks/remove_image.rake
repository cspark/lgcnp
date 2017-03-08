namespace :image do
  desc "Remove image"
  image :remove_image, [:tz] => :environment do |t, args|
    AdminFcdata.remove_image
  end
end
