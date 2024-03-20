class Publisher
  class << self
    def publish(message, exchange_name, routing_key=nil)
      # exchange = channel.fanout(queue_name)
      exchange = channel.direct(exchange_name)
      #no routing key needed for fanout exchange
      exchange.publish(message.to_json, routing_key: "direct_route")
      puts "[x] sent to #{exchange_name}"
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new.start
    end
  end
end