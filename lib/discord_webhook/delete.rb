class DiscordWebhook
	def delete(message_id, thread_id: nil)
		uri = URI("#{@url}/messages/#{message_id}#{'?thread_id=' + thread_id.to_s if thread_id}")

	  Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |https|
	    request = Net::HTTP::Delete.new(uri)

	  	response = https.request(request)

	  	handle_response(response)
	  end
	end # delete
end
