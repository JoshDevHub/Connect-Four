# frozen_string_literal: true

require_relative 'display'
require_relative 'board'

# class holding logic for running connect 4 games
class Game
  include Display
  attr_reader :game_board

  def initialize(game_board:, player_one:, player_two:)
    @game_board = game_board
    @player_one = player_one
    @player_two = player_two
  end

  def play_game
    # placeholder
    # introduction & rules
    # loop start
    # -> player query
    # -> get input + validate
    # -> #place_disc
    # -> if #connect_four? || #board_full?
    # ----> end the loop & declare result
    # -> run this loop with player2 (abs into own method)
    # break when game is over
    # ask if play again is desired
    # reset and run game back if y else end
  end

  private

  def reset_game
    @game_board = game_board.new
  end
end
