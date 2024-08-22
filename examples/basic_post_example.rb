require 'discord_webhook'

# Initialize your webhook object
webhook = DiscordWebhook.new ENV['DISCORD_WEBHOOK']

# Build your request using a Hash object
# See https://discord.com/developers/docs/resources/webhook#execute-webhook for
# a list of valid fields and the values they accept
request = {
  :content => "Hello, World!"
}

# Send your request
webhook.post(request)
