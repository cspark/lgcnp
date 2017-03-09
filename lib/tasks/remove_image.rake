namespace :image do
  desc "Task check reminder"
  task :remove_image: :environment do
    system("mkdir public/TEST3")
  end
end
