# Glove

**Status:** Experimental.

A [Crystal](https://crystal-lang.org/) library for making games.

## Architecture

* `Glove::EntityApp` is a generic game superclass that provides functionality for handling entities, and everything associated with it. Here is how a typical game would build an instance and run the game:

  ```crystal
  game = Glove::EntityApp.new(800, 600, "Inari")
  game.clear_color = Glove::Color::WHITE
  scene = Glove::Scene.new.tap do |scene|
    # … build scene here …
  end
  game.replace_scene(scene)
  game.run
  ```

* `Glove::Entity` is a game object that is visible and/or reacts to user input.

* `Glove::Component` is a property of an entity. A common component is `Glove::Components::Transform`, which adds width, height, rotation, scale, … to an entity. Another common component is `Glove::Components::Camera`, which marks an entity as being a camera, and defines which part of a space (see below) will be rendered, with what rotation, etc.

* `Glove::Action` defines a change to an entity. It can either be instant (e.g. remove entity) or act over time (e.g. move).

* `Glove::Space` groups entities in a scene that logically belong together and can interact with each other. Entities in different spaces never interact. For example, one space might contain the game entities, and another space might contain UI elements.

* `Glove::Scene` describes a scene (such as the main menu, credits, or in-game screen). It contains one or more spaces.

There are also a handful of simple data classes:

* `Glove::Color`
* `Glove::Point`
* `Glove::Quad`
* `Glove::Rect`
* `Glove::Size`
* `Glove::Vector`

## Acknowledgements

This project started out by playing with [crystal-gl](https://github.com/ggiraldez/crystal-gl) by Gustavo Giráldez.
