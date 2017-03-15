class Glove::Metrics::Store
  def initialize
    @counters = {} of Symbol => Float64
    @gauges = {} of Symbol => Float64

    # TODO: extract
    @counters[:glove_frames_total] = 0.0
    @gauges[:glove_entities_total] = 0.0
  end

  def inc(name : Symbol)
    @counters[name] += 1.0
  end

  def set(name : Symbol, value)
    @gauges[name] = value.to_f64
  end

  def txt
    io = MemoryIO.new(1024)

    @counters.each do |name, value|
      io << "# HELP #{name} ???\n"
      io << "# TYPE #{name} counter\n"
      io << "#{name} #{@counters[name]}\n"
    end

    @gauges.each do |name, value|
      io << "# HELP #{name} ???\n"
      io << "# TYPE #{name} gauge\n"
      io << "#{name} #{@gauges[name]}\n"
    end

    io.to_s
  end
end
