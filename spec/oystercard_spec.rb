require 'oystercard.rb'

describe Oystercard do
	let(:entry_station){ double :station }
	let(:exit_station){ double :station }

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
			subject.touch_in(entry_station)
			expect {subject.touch_out(exit_station)}.to change{ subject.balance }.by (-Oystercard::MINIMUM_FARE)
		end
	end

	describe "#touch_in & out" do

		context "insufficient funds" do
		  it "raises an error if insufficient funds" do
		    subject.balance < Oystercard::MINIMUM_FARE
		    expect { subject.touch_in(entry_station) }.to raise_error "Insufficient funds"
		  end
		end
		context "sufficient funds" do
			before do
				subject.top_up(Oystercard::MINIMUM_FARE)
				subject.touch_in(entry_station)
			end

			it "touches in" do
				expect(subject.in_journey?).to eq true
			end

			it "touches out" do
				subject.touch_out(exit_station)
				expect(subject.in_journey?).to be false
			end
		end
	end


describe "station" do
	it 'stores the entry station' do
		subject.top_up(5)
		subject.touch_in(entry_station)
		expect(subject.entry_station).to eq entry_station
	end

	it 'stores the exit station' do
		subject.top_up(5)
		subject.touch_in(entry_station)
		subject.touch_out(exit_station)
		expect(subject.exit_station).to eq exit_station
	end
end


end
