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
    puts column_labels
    puts board
    puts column_labels
  end

  def print_discs(discs)
    disc_string = ''
    discs.each { |disc| disc_string += "#{disc}  " }
    puts disc_string + "\n\n"
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
      not_in_range: 'That input is not in the range of columns you can place your piece in. Try again.',
      column_full: 'That column is already filled! Please choose a different one',
      not_yn: "Please only use 'Y' or 'N' to answer.",
      invalid_name: 'Please only use one word of alphabetical characters',
      invalid_disc: 'Please enter a valid disc color. Name the color you want:',
      chosen_disc: 'Eek! That color has already been picked. Please pick a new one: '
    }[message]
  end
end
