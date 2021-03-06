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

  describe '#choose_disc' do
    context 'when the user picks a valid disc' do
      context 'when the user spells the disk in lowercase letters' do
        subject(:blue_player) { described_class.new }
        before do
          allow(blue_player).to receive(:puts)
          disc_choice = 'blue'
          allow(blue_player).to receive(:gets).and_return(disc_choice)
        end

        it 'sets the disc to be blue' do
          disc_choice = '????'
          expect { blue_player.choose_disc }.to change { blue_player.disc }.to(disc_choice)
        end
      end

      context 'when the user spells the disk with variable casing' do
        subject(:red_player) { described_class.new }
        before do
          allow(red_player).to receive(:puts)
          disc_choice = 'Red'
          allow(red_player).to receive(:gets).and_return(disc_choice)
        end

        it 'sets the disc to be orange' do
          disc_choice = '????'
          expect { red_player.choose_disc }.to change { red_player.disc }.to(disc_choice)
        end
      end
    end

    context 'when the user picks an invalid disc' do
      subject(:incorrect_player) { described_class.new }
      before do
        allow(incorrect_player).to receive(:puts)
        invalid_choice = 'sky-blue'
        valid_choice = 'yellow'
        allow(incorrect_player).to receive(:gets).and_return(invalid_choice, valid_choice)
      end

      it 'sets the disc to the valid option' do
        disc_choice = '????'
        expect { incorrect_player.choose_disc }.to change { incorrect_player.disc }.to(disc_choice)
      end
    end

    context "when the user picks a disc that's already been chosen" do
      let(:player_one) { described_class.new }
      subject(:player_two) { described_class.new }
      before do
        player_one_disc = 'orange'
        allow(player_one).to receive(:puts)
        allow(player_one).to receive(:gets).and_return(player_one_disc)
        valid_player_two_disc = 'purple'
        allow(player_two).to receive(:puts)
        allow(player_two).to receive(:gets).and_return(player_one_disc, valid_player_two_disc)
      end

      it 'sets the disc to the valid option' do
        disc_choice = '????'
        player_one.choose_disc
        expect { player_two.choose_disc }.to change { player_two.disc }.to(disc_choice)
      end
    end
  end
end
