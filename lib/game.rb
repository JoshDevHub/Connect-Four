# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'
require_relative 'user_input'

# module wrapper for Game Logic
module ConnectFour
  # class to hold logic of running a game of Connect Four
  class Game
    include Display
    include UserInput
    attr_reader :game_board, :player_one, :player_two, :game_over

    def initialize(game_board:, player_one:, player_two:)
      @game_board = game_board
      @player_one = player_one
      @player_two = player_two
      @game_over = false
    end

    def play_game
      setup_game
      loop do
        game_loop
        break unless play_again?
      end
    end

    def game_loop
      current_player = player_one
      until game_over
        print_board(game_board)
        puts "#{current_player}: #{query_message(:player_input)}"
        player_choice = column_selection
        game_board.place_disc(current_player.disc, player_choice)
        check_game_over(current_player)
        current_player = current_player == player_one ? player_two : player_one
      end
    end

    def play_again?
      reset_game
      puts query_message(:play_again)
      response = give_yes_no_input
      response == 'y'
    end

    def check_game_over(player)
      if game_board.connect_four?(player.disc)
        @game_over = true
        print_board(game_board)
        puts "#{player} has won the game!"
      elsif game_board.full_board?
        @game_over = true
        puts 'This game is a draw.'
      end
    end

    private

    def setup_game
      puts introduction
      player_one.setup
      player_two.setup
    end

    def column_selection
      error = error_message(:invalid_column)
      user_input(error, &column_validator)
    end

    def column_validator
      ->(input) { game_board.in_range?(input) && !game_board.column_full?(input) }
    end

    def reset_game
      @game_board = game_board.class.new
      @game_over = false
    end
  end

  def self.play
    Game.new(
      game_board: Board.new,
      player_one: Player.new,
      player_two: Player.new
    ).play_game
  end
end
