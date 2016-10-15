require "./tween"

abstract class Glove::Action
  abstract def update(delta_time : Float32)
  abstract def update_wrapped(delta_time : Float32)
end

module Glove::Actions
end

require "./actions/interval"
require "./actions/instant"

require "./actions/change_color"
require "./actions/change_texture"
require "./actions/change_z"
require "./actions/delay"
require "./actions/kill"
require "./actions/move_by"
require "./actions/replace_scene"
require "./actions/rotate_by"
require "./actions/scale_to"
require "./actions/sequence"
require "./actions/spawn"
