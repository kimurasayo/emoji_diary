namespace :push_line do
	desc "日記をつけるリマインド通知"
  task push_line_message: :environment do
    require 'net/http'
    require 'uri'
    require 'json' 

    token = ENV["LINE_CHANNEL_TOKEN"]
    # post先のurl
    uri = URI.parse('https://api.line.me/v2/bot/message/broadcast')
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true

    # Header
    headers = {
      'Authorization'=>"Bearer #{token}",
      'Content-Type' =>'application/json',
      'Accept'=>'application/json'
    }
    send_message = '今日はどんな1日でしたか？絵文字で日記をつけてみましょう。'
    # Body
    params = {"messages" => [{"type" => "text", "text" => send_message}]}

    response = http.post(uri.path, params.to_json, headers)
  end
end
