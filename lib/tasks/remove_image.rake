namespace :image do
  desc "Remove image"
  task :remove_image, [:tz] => :environment do |t, args|
    Rails.logger.info "rake!!!!"
    system("mkdir public/TEST")
  end
end
