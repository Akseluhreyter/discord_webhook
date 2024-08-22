class DiscordWebhook
  def post(request, wait: false, thread_id: nil)
		payload = self.class.generate_request(request)

    # Note: 'Content-Type': 'multipart/form-data; boundary=boundary'
    # The above header field must be present in the request header that sends
    # this multipart form
    response = Net::HTTP.post(
      URI("#{@url}?wait=#{wait}#{'&thread_id=' + thread_id.to_s if thread_id}"),
      payload,
      'Content-Type': 'multipart/form-data; boundary=boundary',
    )

		handle_response(response)
  end # post

  alias execute post
end # Webhook
