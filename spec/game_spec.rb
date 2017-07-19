require 'rspec'
require 'unicode'
require_relative '../lib/game'

describe 'Game' do
  context 'good test' do
    it 'test on word "Привет"' do
      game = Game.new("Привет")
      game.next_step("П")
      game.next_step("р")
      game.next_step("и")
      game.next_step("Й")
      game.next_step("в")
      game.next_step("ф")
      game.next_step("е")
      expect(game.solved?).to eq false
      expect(game.lost?).to eq false
      expect(game.in_progress?).to eq true
      game.next_step("т")
      expect(game.solved?).to eq true
      expect(game.lost?).to eq false
      expect(game.in_progress?).to eq false
    end
  end

  context 'bad test' do
    it 'Bad test on word "Привет"' do
      game2 = Game.new("Привет")
      game2.next_step("П")
      game2.next_step("р")
      game2.next_step("ш")
      expect(game2.errors_left).to eq 6
      game2.next_step("Щ")
      expect(game2.errors_left).to eq 5
      game2.next_step("и")
      game2.next_step("в")
      game2.next_step("ф")
      game2.next_step("е")
      expect(game2.errors_left).to eq 4
      expect(game2.solved?).to eq false
      expect(game2.lost?).to eq false
      expect(game2.in_progress?).to eq true
      game2.next_step("н")
      game2.next_step("г")
      game2.next_step("ц")
      expect(game2.errors_left).to eq 1
      game2.next_step("з")
      expect(game2.lost?).to eq true
      expect(game2.in_progress?).to eq false
    end
  end
end
