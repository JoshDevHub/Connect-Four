# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'

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
    puts introduction
    loop do
      until game_over?
        game_loop(player_one)
        game_loop(player_two)
      end
      break unless play_again?

      reset_game
    end
    print_board(game_board.to_s)
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

  def game_over?
    game_board.connect_four? || game_board.full?
  end

  def reset_game
    @game_board = game_board.new
  end
end

game = Game.new(
  game_board: Board.new,
  player_one: Player.new('🟡'),
  player_two: Player.new('🔴')
)
game.play_game