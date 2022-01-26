# frozen_string_literal: true

require_relative '../lib/game'

describe ConnectFour::Game do # rubocop: disable Metrics/BlockLength
  describe '#validate_user_input' do # rubocop: disable Metrics/BlockLength
    let(:player_one) { double(name: 'Player 1', disc: '🟡') }
    let(:player_two) { double(name: 'Player 2', disc: '🔴') }
    let(:validator) do
      lambda do |input|
        if ('1'..'7').none?(input)
          puts error_message(:not_in_range)
        elsif board.column_full?(input)
          puts error_message(:column_full)
        else
          true
        end
      end
    end
    context 'when user input is valid' do
      let(:board) { double('board') }
      subject(:game_inputs) do
        described_class.new(
          game_board: board,
          player_one: player_one,
          player_two: player_two
        )
      end
      before do
        valid_input = '5'
        allow(board).to receive(:column_full?).and_return(false)
        allow(game_inputs).to receive(:gets).and_return(valid_input)
      end

      it 'displays no error message' do
        error_message = 'That input is not in the range of columns you can place your piece in. Try again.'
        expect(game_inputs).not_to receive(:puts).with(error_message)
        game_inputs.validate_user_input(&validator)
      end
    end

    context 'when user inputs one invalid value, then a valid input' do
      before do
        letter = 'b'
        valid_input = '7'
        allow(player).to receive(:gets).and_return(letter, valid_input)
      end

      xit 'displays error message once' do
        error_message = 'That input is not in the range of columns you can place your piece in. Try again.'
        expect(player).to receive(:puts).with(error_message).once
        player.user_selection
      end
    end

    context 'when user inputs two invalid values, then a valid input' do
      before do
        symbol = ']'
        large_number = '9'
        valid_input = '2'
        allow(player).to receive(:gets).and_return(symbol, large_number, valid_input)
      end

      xit 'displays error message twice' do
        error_message = 'That input is not in the range of columns you can place your piece in. Try again.'
        expect(player).to receive(:puts).with(error_message).twice
        player.user_selection
      end
    end
  end

  describe '#play' do
    context 'when the game is over after four turns' do
      xit 'ends the loop after four turns' do
        # placeholder
      end
    end
  end
end
