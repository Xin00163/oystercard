require 'oystercard.rb'

describe Oystercard do
	let(:station){ double :station}
	context "initial status" do
		it 'has no money at the beginning' do
			expect(subject.balance).to eq 0
		end

		it 'has a balance limit of 90 pounds' do
			maximum_balance = Oystercard::MAXIMUM_BALANCE
			subject.top_up maximum_balance
			expect{ subject.top_up 1 }.to raise_error 'The balance limit is 90 pounds'
		end

		it "initially is not in journey" do
			expect(subject.in_journey?).to be false
		end
	end

	describe "#top_up & deduct" do
		it 'can top up' do
			expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
		end

		it 'can deduct money' do
			subject.top_up 5
			subject.touch_in(station)
			expect {subject.touch_out}.to change{ subject.balance }.by (-Oystercard::MINIMUM_FARE)
		end
	end

	describe "#touch_in & out" do
		it "touches in" do
	    subject.top_up(5)
			subject.touch_in(station)
			expect(subject.in_journey?).to be true

		end

		it "touches out" do
	    subject.top_up(5)
			subject.touch_in(station)
			subject.touch_out
			expect(subject.in_journey?).to be false
		end
	end

context "insufficient funds" do
  it "raises an error if insufficient funds" do
    subject.balance < Oystercard::MINIMUM_FARE
    expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
  end
end

describe "station" do
	it 'stores the entry station' do
		subject.top_up(5)
		subject.touch_in(station)
		expect(subject.entry_station).to eq station
	end
end


end
