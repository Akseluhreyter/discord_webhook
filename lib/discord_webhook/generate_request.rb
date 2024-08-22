class DiscordWebhook
  # multipart/form-data info: https://discord.com/developers/docs/reference#uploading-files
  # JSON/Form Params info: https://discord.com/developers/docs/resources/webhook#execute-webhook-jsonform-params
  #
  # Generates a multipart/form-data request. It can accept any object that
  # implements #to_h. The returned Hash instance should represent the form
  # parameters for a request.
  def self.generate_request(form)
    data = form.to_h.transform_keys(&:to_sym) # Note: IMPORTANT! We will mutate this structure

    # We need to get a hold of attachments and files so we can properly
    # manipulate the payload_json field we will send to Discord
    attachments = data[:attachments]  || []
    files       = data.delete(:files) || []

    # Discord will only read the fields present inside payload_json + files
    # if the payload_json field is given. Therefore, we choose to take it here
    # as well and send it. If payload_json is not present, then all other
    # fields (minus files -- see above) will be used as a placeholder
    payload_json = (data.delete(:payload_json) || data).to_json
    
    # To make things easier for us to work with when accessing fields
    attachments.each do |attachment|
      attachment.transform_keys!(&:to_sym)
    end

    # Note: Arguably, we should error in the following code if we find more 
    # than 1 file. However, that will mean a exception is raised and that will 
    # ultimately cause the user to potentially mix exception catching where                                                           
    # pattern matching is used. So we look the other way and send the data 
    # along anyway and let Discord decide what to do with the data and what to
    # return to the user
    file_data = files.flat_map.with_index do |file_bytes, n|
      # Find all attachments that can pair with this file
      attachments_to_send = attachments.select { |a| a[:id] == n }                

      # The default case. We have a file to send but no corresponding attachment
      attachments_to_send = [{id: n, filename: ''}] if attachments_to_send.empty?

      attachments_to_send.map do |a|
        <<~FILE
          --boundary
          Content-Disposition: form-data; name="files[#{a[:id]}]"; filename="#{a[:filename]}"
          Content-Type: application/octet-stream
  
          #{file_bytes}
        FILE
      end
    end
    
    # Here we take our json payload and the file data we determined
    # above to create the payload that is sent to Discord
    <<~PAYLOAD
      --boundary
      Content-Disposition: form-data; name="payload_json"
      Content-Type: application/json

      #{payload_json}
      #{file_data.join("\n")}
      --boundary--
    PAYLOAD
  end # ::generate_request(data)
end
