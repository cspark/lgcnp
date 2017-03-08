namespace :image do
  desc "Remove image"
  task :remove_image, [:tz] => :environment do |t, args|
    Rails.logger.info "rake!!!!"
    system("mkdir public/TEST")
    # system("rm -rf public/CNP")
    # system("rm -rf public/BEAU")
    # system("rm -rf public/CLAB")
  end
end
