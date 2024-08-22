class DiscordWebhook
  def get(message_id, thread_id: nil)
    uri = URI("#{@url}/messages/#{message_id}#{'?thread_id=' + thread_id.to_s if thread_id}")

    response = Net::HTTP.get_response(uri)

    handle_response(response)
  end
end
