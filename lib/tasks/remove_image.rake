namespace :image do
  task :remove_image do
    run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
    system("rm -rf public/BEAU")
    system("rm -rf public/CNP")
    system("rm -rf public/CLAB")
    system("rm -rf public/LABO")
    system("rm -rf public/MART")
    system("rm -rf public/TMR")
  end
end
