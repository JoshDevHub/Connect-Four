# frozen_string_literal: true

# module for display to the CLI
module Display
  def introduction
    puts <<~HEREDOC
      Welcome to Connect Four!

      The goal of the game is to connect a consecutive row of four discs with your color.
      This row can occur on rows, columns, and diagonals. Player 1 will use the
      yellow discs, and Player 2 will use the red discs. Press Enter to start the game >>
    HEREDOC
    gets
  end

  def print_board(board)
    column_labels = '  1    2    3    4    5    6    7  '
    puts column_labels
    puts board
    puts column_labels
  end

  def query_message(message)
    {
      player_input: 'Which column would you like to place your piece in?',
      play_again: 'Would you like to play again? Y/n '
    }[message]
  end

  def error_message(message)
    {
      not_in_range: 'That input is not in the range of columns you can place your piece in. Try again.',
      column_full: 'That column is already filled! Please choose a different one',
      not_yn: "Please only use 'Y' or 'N' to answer."
    }[message]
  end
end
