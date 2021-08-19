# frozen_string_literal: true

require 'dotenv/load'
require 'bunny-pub-sub/subscriber'
require 'bunny-pub-sub/publisher'
require_relative 'speaker_verification_receive_action.rb'

audio_publisher_config = {
  RABBITMQ_HOSTNAME: ENV['RABBITMQ_HOSTNAME'],
  RABBITMQ_USERNAME: ENV['RABBITMQ_USERNAME'],
  RABBITMQ_PASSWORD: ENV['RABBITMQ_PASSWORD'],
  EXCHANGE_NAME: 'ontrack',
  DURABLE_QUEUE_NAME: 'q.audio',
  # Publisher specific key -- all publishers will post task submissions with this key
  ROUTING_KEY: 'audio.received'
}

audio_subscriber_config = {
  RABBITMQ_HOSTNAME: ENV['RABBITMQ_HOSTNAME'],
  RABBITMQ_USERNAME: ENV['RABBITMQ_USERNAME'],
  RABBITMQ_PASSWORD: ENV['RABBITMQ_PASSWORD'],
  EXCHANGE_NAME: 'ontrack',
  DURABLE_QUEUE_NAME: 'q.audio',
  # No need to define BINDING_KEYS for now!
  # In future, OnTrack will listen to
  # topics related to PDF generation too.
  # That is when we should have BINDING_KEYS defined.
  # BINDING_KEYS: ENV['BINDING_KEYS'],

  # This is enough for now:
  DEFAULT_BINDING_KEY: 'audio.received'
}

audio_publisher = Publisher.new audio_publisher_config

# Register subscriber for task submissions, runs audio receive, and publishes results to audio_publisher
register_subscriber(audio_subscriber_config,
                    method(:receive),
                    audio_publisher)
