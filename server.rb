require 'sinatra'
require 'json'
#load "operations.rb"
#include Opt
load "class.rb"


get '/check' do
  content_type :json
  { response: "Hola Bebe" }.to_json
end

get '/hi' do
  # Specify the content type to return, json
  content_type :json
  { song: "Wake me Up" }.to_json
end

get "/test" do
  #Opt.engage("Bebe")
  opt = Operation.new
  opt.engage("bebe")
  content_type :json
  { response: "Hawaii" }.to_json
end
