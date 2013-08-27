require 'eventmachine'
require 'debugproxy/incoming_connection'
require 'debugproxy/outgoing_connection'

module DebugProxy
  def self.start(listener, remote, options = {})
    listener_host, listener_port = listener.split(':')
    listener_port, listener_host = listener_host, '0.0.0.0' if listener_port.nil?

    remote_host, remote_port = remote.split(':')
    remote_port ||= listener_port

    EM.start_server listener_host, listener_port, InboundConnection, remote_host, remote_port, options
  end
end
