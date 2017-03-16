every :day, :at => '4:00 am' do
  system("rm -rf public/BEAU")
  system("rm -rf public/CNP")
  system("rm -rf public/CLAB")
  system("rm -rf public/LABO")
  system("rm -rf public/MART")
  system("rm -rf public/TMR")
end

every :day, :at => '4:01 am' do
  system("mkdir public/BEAU")
  system("mkdir public/CNP")
  system("mkdir public/CLAB")
  system("mkdir public/LABO")
  system("mkdir public/MART")
  system("mkdir public/TMR")
end
