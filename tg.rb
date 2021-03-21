require "net/http"

#net = Net::HTTP.new("https://api.telegram.org/bot1296926491:AAGukcprD4iUdhK8waRePhLCOtuLOMlbWYk/sendmessage", 443)

#net.use_ssl = true

def notify(id, text)
  
  uri = URI("https://api.telegram.org/bot1296926491:AAGukcprD4iUdhK8waRePhLCOtuLOMlbWYk/sendmessage")
  res = Net::HTTP.post_form(uri, 'chat_id' => id, 'text' => text) 

end
#puts res.body

#net.get_response("/")
