namespace :image do
  desc "Remove image"
  task :remove_image
    Rails.logger.info "rake!!!!"
    system("mkdir public/TEST")
  end
end
