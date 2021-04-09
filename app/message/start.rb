# frozen_string_literal: true

module Message
  class Start
    class << self
      def process(message, bot)
        bot.logger.info('[Message::Start.process] - success')
        bot.logger.info("#{message.from.first_name} #{message.from.last_name} pressed /start")

        bot.api.send_message(
          chat_id: message.chat.id,
          text: get_text(message)
        )
      end

      private

      def get_text(message)
        <<~HEREDOC
          Hello, #{message.from.first_name} 🙂!
          It is a chat bot of BookStore 📚
          You can see all of our products 📖
        HEREDOC
      end
    end
  end
end
