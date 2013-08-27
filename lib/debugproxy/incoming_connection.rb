module DebugProxy
  module InboundConnection
    attr_reader :remote_host, :remote_port, :options

    def initialize(remote_host, remote_port, options)
      @remote_host = remote_host
      @remote_port = remote_port
      @options = options
    end

    def post_init
      port, ip = Socket.unpack_sockaddr_in(get_peername)
      log :<<, :connected, ip, port
      start_tls if options[:ssl]
      @out = EM.connect @remote_host, @remote_port, OutboundConnection, self
    end

    def ssl_handshake_completed
      log :<<, :ssl_complete
    end

    def receive_data(data)
      log :<<, data
      @out.send_data(data)
    end

    def unbind(reason)
      log :<<, :unbind, reason
      @out.close_connection if @out
      @out = nil
    end

    def log(*args)
      p args
    end
  end
end
