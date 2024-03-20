class Publisher
  class << self
    def publish(message, exchange_name, routing_key=nil)

      # queue is not necessary for fanout exchange

      # exchange = channel.fanout(queue_name)
      exchange = channel.direct(exchange_name)
      #no routing key needed for fanout exchange
      exchange.publish(message.to_json, routing_key: "direct_route")
      puts "[x] sent to #{exchange_name}"
    # ensure
    #   connection.close if @connection.open?
    # end
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new
      @connection.start
    end
  end
end