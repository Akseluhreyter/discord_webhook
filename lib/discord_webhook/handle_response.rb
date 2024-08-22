class DiscordWebhook
  # The following method determines what happens when a response body
  # is recieved from an endpoint. 
  #
  # execute/post: is determined by the user when using wait parameter
  # edit/patch:   always returns a response body
  # get:          always returns a response body
  # delete:       never returns a response body
  private def handle_response(response)
    JSON.parse(response.body, symbolize_names: true) if response.body && !response.body.empty?
  end
end
