# frozen_string_literal: true

require_relative '../lib/user_input'

describe UserInput do
  subject(:dummy_class) { Class.new { extend UserInput } }
  error_message = "Please only use 'Y' or 'N' to answer."

  describe '#give_yes_no_input' do
    context 'when the user input is valid' do
      context 'when the user input is Y' do
        before do
          input = 'y'
          # allow(dummy_class).to receive(:error_message).and_return(error_message)
          allow(dummy_class).to receive(:gets).and_return(input)
        end

        it 'returns no error message' do
          expect(dummy_class).not_to receive(:puts).with(error_message)
          dummy_class.give_yes_no_input
        end
      end
      context 'when the user input is N' do
        before do
          input = 'n'
          allow(dummy_class).to receive(:gets).and_return(input)
        end
        it 'returns no error message' do
          expect(dummy_class).not_to receive(:puts).with(error_message)
          dummy_class.give_yes_no_input
        end
      end
    end
    context 'when the user input is invalid once and then valid' do
      before do
        invalid_letter = 'a'
        valid_input = 'y'
        allow(dummy_class).to receive(:gets).and_return(invalid_letter, valid_input)
      end
      it 'returns an error message once' do
        expect(dummy_class).to receive(:puts).with(error_message).once
        dummy_class.give_yes_no_input
      end
    end
  end
end
