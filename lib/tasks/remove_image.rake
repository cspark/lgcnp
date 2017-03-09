namespace :image do
  task :remove_image: :environment do
    system("mkdir public/TEST3")
  end
end
