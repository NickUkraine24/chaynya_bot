# frozen_string_literal: true

module Message
  class Menu
    class << self
      def process(message, bot)
        bot.logger.info('[Message::Menu.process] - success')
        bot.logger.info("#{message.from.first_name} #{message.from.last_name} pressed /menu")

        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: get_keyboards)

        bot.api.send_message(
          chat_id: message.chat.id,
          text: 'Please, choose what you want:',
          reply_markup: markup
        )
      end

      private

      def get_keyboards
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Visit our website 🖥', url: 'https://google.com'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'See a menu 📚', callback_data: 'menu'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Contacts 📱', callback_data: 'contacts')
        ]
      end
    end
  end
end

