namespace :image do
  task :remove_image do
    system("rm -rf public/BEAU")
    system("rm -rf public/CNP")
    system("rm -rf public/CLAB")
    system("rm -rf public/LABO")
    system("rm -rf public/MART")
    system("rm -rf public/TMR")
  end
end
