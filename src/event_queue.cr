class Glove::EventQueue
  def initialize
    @events = [] of Glove::Event
  end

  def <<(event : Glove::Event)
    @events << event
  end

  def handle
    @events.each { |e| yield(e) }
    @events.clear
  end
end
