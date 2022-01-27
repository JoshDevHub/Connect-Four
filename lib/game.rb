# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'
require_relative 'user_input'
require 'pry-byebug'

module ConnectFour
  class Game
    include Display
    include UserInput
    attr_reader :game_board, :player_one, :player_two

    def initialize(game_board:, player_one:, player_two:)
      @game_board = game_board
      @player_one = player_one
      @player_two = player_two
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
      until @game_over
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
    end

    def column_selection
      validate_user_input(&column_validator)
    end

    def column_validator
      lambda do |input|
        if ('1'..'7').none?(input)
          puts error_message(:not_in_range)
        elsif game_board.column_full?(input)
          puts error_message(:column_full)
        else
          true
        end
      end
    end

    def reset_game
      @game_board = game_board.class.new
      @game_over = false
    end
  end

  def self.play
    Game.new(
      game_board: Board.new,
      player_one: Player.new('🟡', 'Player 1'),
      player_two: Player.new('🔴', 'Player 2')
    ).play_game
  end
end
