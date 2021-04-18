# frozen_string_literal: true

require 'faraday'
require 'loofah'
require 'open-uri'
require_relative '../../lib/items'

module Callback
  class Menu

    attr_reader :message, :bot

    def initialize(message, bot)
      @message = message
      @bot     = bot
    end

    def process
      bot.logger.info('[Callback::Menu.process] - success')

      bot.api.send_message(chat_id: message.from.id, text: 'You can see a menu!')

      items = Lib::Items.process

      items.map do |order|
        bot.logger.info(order)

        bot.api.send_photo(
          chat_id: message.from.id,
          photo: get_photo(order)
        )

        bot.api.send_message(
          chat_id: message.from.id,
          text: get_text(order)
        )
      end
    end

    private

    def get_photo(order)
      bot.logger.info('[Callback::Menu.get_photo] - success')

      if order['image_url'].include? 'http'
        bot.logger.info('[Callback::Menu.get_photo] - include http')

        download = URI.parse(order['image_url']).open
        path = ENV['PATH_FOR_IMAGES'] + download.base_uri.to_s.split('/')[-1]

        IO.copy_stream(download, path) unless File.exist?(path)
      else
        path = ENV['PATH_FOR_IMAGES'] + order['image_url']
      end

      Faraday::UploadIO.new(
        path,
        'image/jpeg'
      )
    end

    def get_text(order)
      bot.logger.info('[Callback::Menu.get_text] - success')

      <<~HEREDOC
        🔘Name: #{get_title(order)}
        🔘Description: #{get_description(order)}
        🔘Price: $#{get_price(order)}
      HEREDOC
    end

    def get_title(order)
      bot.logger.info('[Callback::Menu.get_title] - success')

      order['title']
    end

    def get_description(order)
      bot.logger.info('[Callback::Menu.get_description] - success')

      Loofah.fragment(order['description']).text.gsub(/\s+/, ' ').strip
    end

    def get_price(order)
      bot.logger.info('[Callback::Menu.get_price] - success')

      order['price'].split('.')[0]
    end
  end
end
