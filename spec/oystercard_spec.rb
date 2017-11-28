require 'oystercard.rb'

describe Oystercard do

	it 'has no money at the beginning' do
		expect(subject.balance).to eq 0
	end

	it 'can top up' do
		expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
	end

	it 'has a balance limit of 90 pounds' do
		maximum_balance = Oystercard::MAXIMUM_BALANCE
		subject.top_up maximum_balance
		expect{ subject.top_up 1 }.to raise_error 'The balance limit is 90 pounds'
	end

	it 'can deduct money' do
		subject.top_up 5
		expect {subject.deduct(5)}.to change{ subject.balance }.by (-5)
	end

  it "initially is not in journey" do
    expect(subject.in_journey).to be false
  end

	it "touches in" do
		subject.touch_in
		expect(subject.in_journey).to be true
	end

	it "touches out" do
		subject.touch_in
		subject.touch_out
		expect(subject.in_journey).to be false
	end
end
