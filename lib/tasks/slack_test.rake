namespace :image do
  task :slack_test do
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping "Staging Slack TEST Execute !!!"
  end
end
