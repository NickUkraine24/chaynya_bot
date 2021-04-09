# frozen_string_literal: true

require_relative 'contacts'
require_relative 'menu'

module Callback
  class Main
    class << self
      def process(message, bot)
        case message
        when Telegram::Bot::Types::CallbackQuery
          bot.logger.info('[Callback::Main.process] - success')

          case message.data
          when 'contacts'
            Contacts.process(message, bot)
          when 'menu'
            Menu.new(message, bot).process
          end
        end
      end
    end
  end
end
