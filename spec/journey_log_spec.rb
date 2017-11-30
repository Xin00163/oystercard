require 'journey_log'

describe JourneyLog do
  let (:station) {double :station, zone: 1}
  let (:station2) {double :station, zone: 1}

  describe "#start" do
    it 'starts a new journey' do
      subject.start(station)
      expect(subject.start(station)).to be_a(Journey)
    end
  end

  describe "#finish" do
    it "finishes a journey" do
      subject.start(station)
      subject.finish(station2)
      expect(subject.journeys).to include subject.current_journey
    end
  end

  describe "#charge" do
    it 'charges minimum fare' do
      subject.start(station)
      subject.finish(station2)
      expect(subject.charge).to eq Journey::MINIMUM_FARE
    end
    it 'charges penalty for not touching out' do
      subject.start(station)
      subject.finish(nil)
      expect(subject.charge).to eq Journey::PENALTY_FARE
    end
    it 'charges penalty for not touching in' do
      subject.start(nil)
      subject.finish(station)
      expect(subject.charge).to eq Journey::PENALTY_FARE
    end
  end

  describe "#reset" do
    it 'will reset current_journey to nil' do
      subject.start(station)
      subject.finish(station2)
      subject.reset
    expect(subject.reset).to eq nil
    end
  end



end
