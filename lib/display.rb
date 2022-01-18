# frozen_string_literal: true

# module for stdout to the CLI
module Display
  def introduction
    puts <<~HEREDOC
      Welcome to Connect Four!
    HEREDOC
  end

  def query_message(message)
    {
      player_input: 'Which column would you like to place your piece in?'
    }[message]
  end

  def error_message(message)
    {
      disk_insert: 'That input is not in the range of columns you can place your piece in. Try again.'
    }[message]
  end
end
