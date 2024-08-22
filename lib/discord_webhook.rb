require 'net/http'
require 'json'

require_relative 'discord_webhook/handle_response'
require_relative 'discord_webhook/generate_request'

require_relative 'discord_webhook/post'
require_relative 'discord_webhook/get'
require_relative 'discord_webhook/patch'
require_relative 'discord_webhook/delete'

class DiscordWebhook
  def initialize(url)
    @url = url
  end
end # Webhook
