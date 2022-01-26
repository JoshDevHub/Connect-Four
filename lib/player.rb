# frozen_string_literal: true

# class that holds logic for the game's players
class Player
  attr_reader :disc, :name

  def initialize(disc_token, name)
    @disc = disc_token
    @name = name
  end
end
