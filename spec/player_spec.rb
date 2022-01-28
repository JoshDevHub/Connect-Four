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

      it "sets name to be 'Josh'" do
        user_name = 'Josh'
        expect { josh_player.input_name }.to change { josh_player.name }.to(user_name)
      end
    end

    context "when the user inputs 'Amanda'" do
      subject(:amanda_player) { described_class.new }
      before do
        allow(amanda_player).to receive(:puts)
        user_input = 'Amanda'
        allow(amanda_player).to receive(:gets).and_return(user_input)
      end

      it "sets name to be 'Amanda'" do
        user_name = 'Amanda'
        expect { amanda_player.input_name }.to change { amanda_player.name }.to(user_name)
      end
    end

    context 'when the user inputs a name with non-alphabetical chars' do
      subject(:player) { described_class.new }
      before do
        allow(player).to receive(:puts)
        non_alpha_input = '123'
        valid_input = 'player'
        allow(player).to receive(:gets).and_return(non_alpha_input, valid_input)
      end

      it 'sets name to the valid name' do
        valid_name = 'player'
        expect { player.input_name }.to change { player.name }.to(valid_name)
      end
    end

    context 'when the user inputs a name that is too long' do
      subject(:long_name) { described_class.new }
      before do
        allow(long_name).to receive(:puts)
        long_input = 'abcdefghijklmnopqrstuvwxyz'
        valid_input = 'player'
        allow(long_name).to receive(:gets).and_return(long_input, valid_input)
      end

      it 'sets name to the valid name' do
        valid_name = 'player'
        expect { long_name.input_name }.to change { long_name.name }.to(valid_name)
      end
    end
  end
end
