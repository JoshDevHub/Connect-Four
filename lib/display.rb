# frozen_string_literal: true

# module for stdout to the CLI
module Display
  def introduction
    puts <<~HEREDOC
      Welcome to Connect Four!
    HEREDOC
  end
end
