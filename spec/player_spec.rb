# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#input_name' do
    context "when the user inputs 'Josh'" do
      subject(:josh_player) { described_class.new }
      before do
        allow(josh_player).to receive(:puts)
        user_input = 'Josh'
        allow(josh_player).to receive(:gets).and_return(user_input)
      end

      xit "sets name to be 'Josh'" do
        expect { josh_player.input_name }.to change { josh_player.name }.to('Josh')
      end
    end

    context "when the user inputs 'Amanda'" do
      subject(:amanda_player) { described_class.new }
      before do
        allow(amanda_player).to receive(:puts)
        user_input = 'Amanda'
        allow(amanda_player).to receive(:gets).and_return(user_input)
      end
      xit "sets name to be 'Amanda'" do
        # placeholder
      end
    end

    context 'when the user inputs an invalid name once' do

      xit "runs twice" do

      end
    end
  end
end
