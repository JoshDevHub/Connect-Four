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
      puts introduction
      loop do
        current_player = player_one
        loop do
          game_loop(current_player)
          break if @game_over

          current_player = current_player == player_one ? player_two : player_one
        end
        break unless play_again?
      end
    end

    private

    def game_loop(player)
      print_board(game_board.to_s)
      puts query_message(:player_input)
      player_choice = column_selection
      game_board.place_disc(player.disc, player_choice)
      check_game_over(player)
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

    def check_game_over(player)
      if game_board.connect_four?(player.disc)
        @game_over = true
        print_board(game_board.to_s)
        puts "#{player.name} has won the game!"
      elsif game_board.full_board?
        @game_over = true
        puts 'This game is a draw.'
      end
    end

    def reset_game
      @game_board = game_board.new
      @game_over = false
    end

    def play_again?
      puts query_message(:play_again)
      response = give_yes_no_input
      response == 'y'
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
