# frozen_string_literal: true

def receive(subscriber_instance, channel, results_publisher, delivery_info, _properties, params)
  puts "*" * 120
  puts "*" * 120
  params = JSON.parse(params)
  
  puts "params: #{JSON.pretty_generate(params)}"

end