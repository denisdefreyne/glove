# Glove

Glove is a framework for making games. It is implemented in [Crystal](https://crystal-lang.org/).

**⚠ Caution! ⚠** Glove is experimental. Expect breaking changes. There are few tests. Do not use this for your own projects (yet).

## Usage

To use this shard, add the following lines to your `shard.yml`:

```yaml
dependencies:
  glove:
    git: git@github.com:ddfreyne/glove.git
```

Glove comes with shaders in its `shaders/` directory, which needs to be copied to where the executable is located. For example, the following will create a `target/` directory that contains the executable and the shaders directory:

```bash
rm -rf target/
mkdir -p target

crystal build -o target/mygame src/mygame.cr

cp -r lib/glove/src/shaders target/shaders
```

It is useful to let the executable `cd` to the directory it is located in, before doing anything else, so that it can find the shaders easily:

```crystal
if full_path = Process.executable_path
  Dir.cd(File.dirname(full_path))
end
```

The `target/` directory should also include any assets that the game needs to run; a more complete build script could therefore look as follows:

```bash
rm -rf target/
mkdir -p target

crystal build -o target/mygame src/mygame.cr

cp -r lib/glove/src/shaders target/shaders
cp -r assets target/assets # <- added
```

## Example code

Here is a trivial example that renders a card (from `assets/card.png`):

```crystal
require "glove"

if full_path = Process.executable_path
  Dir.cd(File.dirname(full_path))
end

card =
  Glove::Entity.new.tap do |e|
    e << Glove::Components::Texture.new("assets/card.png")
    e << Glove::Components::Transform.new.tap do |t|
      t.width = 140_f32
      t.height = 190_f32
      t.translate_x = 400_f32
      t.translate_y = 300_f32
    end
  end

scene =
  Glove::Scene.new.tap do |scene|
    scene.spaces << Glove::Space.new.tap do |space|
      space.entities << card
    end
  end

game = Glove::EntityApp.new(800, 600, "Inari")
game.clear_color = Glove::Color::WHITE
game.replace_scene(scene)
game.run
```

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

* `Glove::System` describes logic for making changes to a space. A common system is a physics system, which would calculate velocities and update positions.

There are also a handful of simple data classes:

* `Glove::Color`
* `Glove::Point`
* `Glove::Quad`
* `Glove::Rect`
* `Glove::Size`
* `Glove::Vector`

## Acknowledgements

This project started out by playing with [crystal-gl](https://github.com/ggiraldez/crystal-gl) by Gustavo Giráldez.
