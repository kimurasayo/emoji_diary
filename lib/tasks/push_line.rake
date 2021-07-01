namespace :push_line do
	desc "日記をつけるリマインド通知"
  task push_line_message: :environment do
    message = {
      type: 'text',
      text: '今日はどんな1日でしたか？絵文字で日記をつけてみましょう。'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    User.all.each do |user|
      client.push_message(user.uid, message)
    end
  end
end
