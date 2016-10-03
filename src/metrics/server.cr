class Metrics::Server
  def initialize(@store, @port = 8090)
    @server = HTTP::Server.new(@port) do |request|
      HTTP::Response.ok "text/plain; version=0.0.4", @store.txt
    end
  end

  def run
    puts "[metrics] started on http://0.0.0.0:#{@port}"
    @server.listen
    puts "[metrics] stopped"
  end

  def stop
    # FIXME: doesn’t stop the server
    puts "[metrics] stopping"
    @server.close
    puts "[metrics] stopped"
  end
end
