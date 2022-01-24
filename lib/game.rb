# frozen_string_literal: true

require_relative 'display'
require_relative 'board'

# class holding logic for running connect 4 games
class Game
  include Display
  attr_reader :game_board

  def initialize(game_board)
    @game_board = game_board
  end
end
