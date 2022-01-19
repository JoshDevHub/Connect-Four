# frozen_string_literal: true

require_relative '../lib/player'

describe Player do # rubocop: disable Metrics/BlockLength
  subject(:player) { described_class.new }
  describe '#user_selection' do # rubocop: disable Metrics/BlockLength
    context 'when user input is valid' do
      before do
        valid_input = '5'
        allow(player).to receive(:gets).and_return(valid_input)
      end

      it 'displays no error message' do
        error_message = 'That input is not in the range of columns you can place your piece in. Try again.'
        expect(player).not_to receive(:puts).with(error_message)
        player.user_selection
      end
    end

    context 'when user inputs one invalid value, then a valid input' do
      before do
        letter = 'b'
        valid_input = '7'
        allow(player).to receive(:gets).and_return(letter, valid_input)
      end

      it 'displays error message once' do
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

      it 'displays error message twice' do
        error_message = 'That input is not in the range of columns you can place your piece in. Try again.'
        expect(player).to receive(:puts).with(error_message).twice
        player.user_selection
      end
    end
  end
end
