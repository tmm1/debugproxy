module DebugProxy
  module OutboundConnection
    def initialize(other)
      @in = other
      @connected = false
      @buf = ''
      log :>>, :connecting, @in.remote_host, @in.remote_port
    end

    def options
      @in.options if @in
    end

    def connection_completed
      log :>>, :connected
      if options[:ssl]
        start_tls
      else
        @connected = true
        send_data(@buf) if @buf
        @buf = nil
      end
    end

    def ssl_handshake_completed
      log :>>, :ssl_complete
      @connected = true
      send_data(@buf) if @buf
      @buf = nil
    end

    def receive_data(data)
      log :>>, data
      @in.send_data(data)
    end

    def send_data(data)
      if !@connected
        @buf << data
      else
        super
      end
    end

    def unbind(reason)
      log :>>, :unbind, reason
      @in.close_connection_after_writing if @in
    end

    def log(*args)
      p args
    end
  end
end
