class DiscordWebhook
  def patch(message_id, request, thread_id: nil)
    payload = self.class.generate_request(request)

    uri = URI("#{@url}/messages/#{message_id}#{'?thread_id=' + thread_id.to_s if thread_id}")

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |https|
      resource_request = Net::HTTP::Patch.new(uri)

      resource_request.content_type = 'multipart/form-data; boundary=boundary'
      resource_request.body = payload

      response = https.request(resource_request)

      handle_response(response)
    end
  end # patch

  alias edit patch
end
