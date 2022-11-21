require 'slack-ruby-client'

Slack.configure do |config|
    config.token = ENV['slack_api_token']
end
