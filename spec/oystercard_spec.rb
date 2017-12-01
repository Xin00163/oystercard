require 'oystercard'
require 'journey'
require 'journey_log'

describe Oystercard do
  let(:entry_station) { double :station, zone: 1 }
  let(:exit_station)  { double :station, zone: 1 }
  let(:journey) { double :journey }
  subject(:card) { described_class.new(20) }
  subject(:empty_card) { described_class.new }

  it 'has no money at the beginning' do
    expect(empty_card.balance).to eq Oystercard::DEFAULT_BALANCE
  end
  it 'should have an empty list of journeys by default' do
    expect(card.journey_log.journeys).to be_empty
  end

  context '#top_up' do
    it 'can top up' do
      expect { card.top_up(5) }.to change { card.balance }.by 5
    end

    it 'will raise an error when the balance is more than the limit' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      expect { card.top_up(maximum_balance) }.to raise_error 'The balance limit is 90 pounds'
    end
  end

  context '#touch_in' do
    it 'should remeber the statiion after touch in' do
      card.touch_in(entry_station)
      expect(card.journey_log.current_journey.entry_station).to eq entry_station
    end

    it 'raises an error if insufficient funds' do
      expect { empty_card.touch_in(entry_station) }.to raise_error 'Insufficient funds'
    end

    it 'deduct penalty fee when you touch in twice' do
      card.touch_in(entry_station)
      expect { card.touch_in(exit_station) }.to change { card.balance }.by(-Journey::PENALTY_FARE)
    end
  end

  context '#touch_out' do
    before { card.touch_in(entry_station) }

    it 'should deduct journey fare' do
      expect { card.touch_out(exit_station) }.to change { card.balance }.by -Journey::MINIMUM_FARE
    end

    it 'should save exit station when card touches out' do
      card.touch_out(exit_station)
      expect(card.journey_log.journeys.last.exit_station).to eq exit_station
    end

    it 'should deduct PENALTY_FARE if we touch out twice' do
      card.touch_out(exit_station)
      expect { card.touch_out(entry_station) }.to change { card.balance }.by(-Journey::PENALTY_FARE)
    end
  end
end
