# frozen_string_literal: true

# module for display to the CLI
module Display
  def introduction
    puts <<~HEREDOC
      Welcome to Connect Four!

      The goal of the game is to connect a consecutive row of discs with your color.
      This row can occur on rows, columns, and diagonals. Player 1 will use the
      yellow discs, and Player 2 will use the red discs. Press Enter to start the game >>
    HEREDOC
    gets.chomp
  end

  def query_message(message)
    {
      player_input: 'Which column would you like to place your piece in?'
    }[message]
  end

  def error_message(message)
    {
      not_in_range: 'That input is not in the range of columns you can place your piece in. Try again.'
    }[message]
  end
end
