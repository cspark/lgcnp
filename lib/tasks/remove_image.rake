namespace :image do
  task :remove_image do
    system("mkdir public/BEAU")
    system("mkdir public/CNP")
    system("mkdir public/CLAB")
    system("mkdir public/CNPR")
    system("mkdir public/RLAB")
    system("mkdir public/LABO")
    system("mkdir public/MART")
    system("mkdir public/TMR")
    system("mkdir public/ONEP")

    system("rm -rf public/BEAU/*")
    system("rm -rf public/CNP/*")
    system("rm -rf public/CLAB/*")
    system("rm -rf public/CNPR/*")
    system("rm -rf public/RLAB/*")
    system("rm -rf public/LABO/*")
    system("rm -rf public/MART/*")
    system("rm -rf public/TMR/*")
    system("rm -rf public/ONEP/*")

    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping "CNP Image Remove Execute !!!"
  end
end
