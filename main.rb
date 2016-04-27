require 'sinatra'
#require './lib/twilio_caller'
require 'dotenv'

Dotenv.load

get '/' do
  'hoge'
  #erb :index
end
