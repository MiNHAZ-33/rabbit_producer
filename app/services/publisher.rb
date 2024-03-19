class Publisher
  def initialize
    @connection = Bunny.new
  end
  def publish(message, queue_name, routing_key=nil)
    @connection.start
    channel = @connection.create_channel
    # queue is not necessary for fanout exchange
    queue = channel.queue(queue_name)
    # channel.default_exchange.publish(message.to_json, routing_key: queue.name)
    exchange = channel.fanout(queue_name)
    exchange.publish(message.to_json)
    puts "[x] sent to #{queue_name}"
  ensure
    @connection.close if @connection.open?
  end

  def consume
    @connection.start
    channel = @connection.create_channel
    queue = channel.queue('hello')
    begin
      puts '[x x] waiting for message'
      queue.subscribe(block: true) do |delivery_info, _properties, body|
        puts "[x] recieved #{body}"
      end
    rescue Interrupt => _
      @connection.close
    end
  end
end