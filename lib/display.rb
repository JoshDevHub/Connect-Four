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
end
