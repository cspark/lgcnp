ActiveSupport::TimeZone.all.each do |timezone|
  Time.zone = timezone.name

  every :day, :at => Time.zone.parse('10:20 am').utc do
    system("rm -rf public/BEAU")
    system("rm -rf public/CNP")
    system("rm -rf public/CLAB")
    system("rm -rf public/LABO")
    system("rm -rf public/MART")
    system("rm -rf public/TMR")
  end

  every :day, :at => Time.zone.parse('10:21 am').utc do
    system("mkdir public/BEAU")
    system("mkdir public/CNP")
    system("mkdir public/CLAB")
    system("mkdir public/LABO")
    system("mkdir public/MART")
    system("mkdir public/TMR")
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping "CNP system Execute !!!"
  end
end
