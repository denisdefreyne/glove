class Glove::EntityCollection
  include Enumerable(Glove::Entity)

  def initialize
    @entities = [] of Glove::Entity
  end

  def each
    @entities.each { |e| yield(e) }
  end

  def <<(entity)
    @entities << entity
  end

  def remove_dead
    @entities.reject! &.dead?
  end

  def unwrap
    @entities
  end
end
