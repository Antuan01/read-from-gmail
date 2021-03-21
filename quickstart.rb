require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"
require "json"
require "base64"
load "tg.rb"

OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Gmail API Ruby Quickstart".freeze
CREDENTIALS_PATH = "credentials.json".freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = "token.yaml".freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# Initialize the API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Show the user's labels
user_id = "me"
result = service.list_user_labels user_id
#puts "Labels:"
#puts "No labels found" if result.labels.empty?
#result.labels.each { |label| puts "- #{label.name}" }

labels_ids = ["UNREAD"]

mails = service.list_user_messages "me" ["UNREAD"]

#mails.messages.each { |msg| puts "- #{msg.id} "}

for msg in mails.messages do
  email = service.get_user_message("me", msg.id)
  data = JSON.parse(email.to_json)

  #partes = data["payload"]["parts"]

  #partes = partes.sort_by! { | el | el["body"]["size"] }

  #partesjson =  JSON.parse(partes.to_json)

  #for asdf in partesjson
  #  puts asdf["body"]["size"]
  #end

  #for part in data["payload"]["parts"]

    #puts part["body"]["data"]

    decode = Base64.urlsafe_decode64(data["payload"]["parts"][0]["body"]["data"])

    #p part["body"]["size"]

    name = decode.match(/([A-Z]+\s[A-Z]+\s[A-Z]+\s[A-Z]{0,})/)

    date =  decode.match(/(\d)+\/(\d)+\/(\d)+/)

    amount = decode.match(/\$(\d+)\.(\d+)/)

    code =  decode.match(/([0-9A-Z]){8,}/)

    uuid = decode.match(/[0-9a-z]+\-[0-9a-z]+\-[0-9a-z]+\-[0-9a-z]+\-[0-9a-z]+/)
    
    if name && date && amount && code && uuid

      puts " #{name} #{date} #{amount} #{code} #{uuid}"
      
      text = " Nuevo pago de: #{name} hoy: #{date} por: #{amount} codigo de confirmacion: #{code} compra: #{uuid} "

      notify("229728941" ,text)
      #notify("229728941" ,text)
      
    end
  #end

  #puts "------------------------------"
end

