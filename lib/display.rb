# frozen_string_literal: true

# module for display to the CLI
module Display
  def introduction
    puts <<~HEREDOC
      Welcome to Connect Four!

      The goal of the game is to connect a consecutive row of four of your discs.
      This consecutive row can occur on horizontal rows, vertical columns, or
      along diagonals. Press Enter to continue >>
    HEREDOC
    gets
  end

  def print_board(board)
    column_labels = '  1    2    3    4    5    6    7  '
    puts blank_line
    puts column_labels
    puts board
    puts column_labels
  end

  def print_discs(discs)
    disc_string = ''
    discs.each { |disc| disc_string += "#{disc}  " }
    puts blank_line + disc_string + blank_line
  end

  def disc_message(disc)
    puts "You've chosen to play with #{disc}"
    puts "Excellent choice! #{blank_line}"
  end

  def query_message(message)
    {
      player_name: 'What would you like your name to be?',
      disc_choice: 'What would your disc color to be?',
      player_input: 'Which column would you like to place your piece in?',
      play_again: 'Would you like to play again? Y/n '
    }[message]
  end

  def error_message(message)
    {
      invalid_column: "Please only use numbers 1-7, and don't try to place a piece in a full column.",
      not_yn: "Please only use 'Y' or 'N' to answer.",
      invalid_name: 'Please only use one word of alphabetical characters',
      invalid_disc: "Please enter a valid disc color. Note that you can't pick a disc that's already been chosen"
    }[message]
  end

  def blank_line
    "\n\n"
  end
end
