# frozen_string_literal: true

require_relative 'start'
require_relative 'menu'

module Message
  class Main
    class << self
      def process(message, bot)
        case message
        when Telegram::Bot::Types::Message
          bot.logger.info('[Message::Main.process] - success')

          case message.text
          when '/start'
            Start.process(message, bot)
          when '/menu'
            Menu.process(message, bot)
          else
            bot.api.send_message(
              chat_id: message.chat.id,
              text: "Sorry, #{message.from.first_name}, we don't have answer on your request."
            )
          end
        end
      end
    end
  end
end
