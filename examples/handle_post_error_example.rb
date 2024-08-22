# This example intentionally sends a failing request to demonstrate how to 
# handle errors from the API
require 'discord_webhook'

webhook = DiscordWebhook.new ENV['DISCORD_WEBHOOK']

# Discord will not accept requests with only empty content
request = {
  :content => "",
}

message = webhook.post request, wait: true

# On error, Discord will respond with a JSON object containing an error message
# and an error code. 
case message
in message: , code: 
  puts "Received: #{message} with code: #{code}"
else
  puts "Success."
end
