# frozen_string_literal: true

require_relative 'display'
require_relative 'user_input'

# class that holds logic for the game's players
class Player
  include Display
  attr_reader :disc, :name

  def initialize(disc_token: nil, name: nil)
    @disc = disc_token
    @name = name
  end

  def to_s
    name
  end
end
