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
    line_user_id = message['content']['from']

    if text =~ /^[\d +-\/*]*$/  # 数式形式
      response = client.send_text([line_user_id], text: eval(text))
    else
      response = client.send_text([line_user_id], text: '数式で入力しろよ')
    end

    puts response
  end

  'OK'
end

get '/facebook_verify' do
  ENV['FABOOK_VERIFY']
end
