require 'dotenv'
require 'sinatra'
require 'json'
require 'line/bot/client'

Dotenv.load

CONTENT_TYPE_TEXT = 1

get '/' do
  'hoge'
end

post '/' do
  client = Line::Bot::Client.new do |config|
    config.channel_id     = ENV['LINE_CHANNEL_ID']
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_mid    = ENV["LINE_CHANNEL_MID"]
    config.proxy          = ENV["FIXIE_URL"]
  end

  params = JSON.parse(request.body.read)
  params['result'].each do |message|
    next unless message['content']['contentType'] == CONTENT_TYPE_TEXT
    text = message['content']['text']
    puts "text: #{text}"
    next text =~ /^[\d +-\/*]*$/  # 数式以外は処理しない

    line_user_id = message['content']['from']
    response = client.send_text([line_user_id], text: eval(text))
    puts response
  end

  'OK'
end
