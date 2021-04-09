require 'telegram/bot'
require 'dotenv/load'

require_relative 'app/callback/main'
require_relative 'app/message/main'

Telegram::Bot::Client.run(ENV['TOKEN'], logger: Logger.new($stderr)) do |bot|
  bot.listen do |message|
    bot.logger.info('[Telegram::Bot::Client] - start')
    bot.logger.info(message)

    Callback::Main.process(message, bot)
    Message::Main.process(message, bot)
  end
end
