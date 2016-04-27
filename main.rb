require 'dotenv'
require 'sinatra'
require 'json'
require 'line/bot/client'

Dotenv.load

get '/' do
  'hoge'
end

post '/' do
  client = Line::Bot::Client.new do |config|
    config.channel_id     = ENV['LINE_CHANNEL_ID']
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_mid    = ENV["LINE_CHANNEL_MID"]
  end

  params = JSON.parse(request.body.read)
  params['result'].each do |message|
    line_user_id = message['content']['from']
    puts "line_user_id: #{line_user_id}"
  end

  client.send_text([line_user_id], text: "Hello LINE!")


  #params = JSON.parse(request.body.read)
  #
  # params['result'].each do |msg|
  #   request_content = {
  #     to: [msg['content']['from']],
  #     toChannel: 1383378250, # Fixed  value
  #     eventType: "138311608800106203", # Fixed value
  #     content: msg['content']
  #   }
  #
  # endpoint = 'https://trialbot-api.line.me/v1/events'
  #
  #   RestClient.proxy = ENV["FIXIE_URL"]
  #   RestClient.post(endpoint_uri, content_json, {
  #     'Content-Type' => 'application/json; charset=UTF-8',
  #     'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
  #     'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
  #     'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
  #   })
  # end
  #
  # "OK"
end
