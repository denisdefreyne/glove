abstract class Glove::Event
end

module Glove::Events
end

class Glove::Events::Key < Glove::Event
  getter :key

  def initialize(@direction : Symbol, @key : Int32)
  end

  def pressed?
    @direction == :down
  end

  def released?
    @direction == :up
  end
end

class Glove::Events::MousePressed < Glove::Event
  getter :button

  def initialize(@button : Symbol)
  end
end

class Glove::Events::MouseReleased < Glove::Event
  getter :button

  def initialize(@button : Symbol)
  end
end

class Glove::Events::CursorEntered < Glove::Event
end

class Glove::Events::CursorExited < Glove::Event
end
