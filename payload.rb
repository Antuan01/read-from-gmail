require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"
load "tg.rb"
require "json"
require "base64"


OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Gmail API Ruby Quickstart".freeze
CREDENTIALS_PATH = "credentials.json".freeze
TOKEN_PATH = "token.yaml".freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

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

def check_mail
  service = Google::Apis::GmailV1::GmailService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize

  user_id = "me"
  mails = service.list_user_messages "me" ["UNREAD"]
  for msg in mails.messages do
    email = service.get_user_message("me", msg.id)
    data = JSON.parse(email.to_json)
    decode = Base64.urlsafe_decode64(data["payload"]["parts"][0]["body"]["data"])
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

  end

end
