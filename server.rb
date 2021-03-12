require 'sinatra'
require 'json'

get '/' do
  content_type :json
  { response: "Hola Bebe" }.to_json
end

get '/hi' do
  # Specify the content type to return, json
  content_type :json
  { song: "Wake me Up" }.to_json
end
