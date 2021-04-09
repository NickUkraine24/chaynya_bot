# frozen_string_literal: true

module Callback
  class Contacts
    class << self
      def process(message, bot)
        bot.logger.info('[Callback::Contacts.process] - success')

        bot.api.send_message(chat_id: message.from.id, text: "☎️Phone number: \n#{ENV['PHONE_NUMBER']}")
      end
    end
  end
end
