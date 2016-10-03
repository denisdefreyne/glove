abstract struct Glove::EventHandler
  abstract def handle(event : Glove::Event, entity : Glove::Entity, space, app)
end
