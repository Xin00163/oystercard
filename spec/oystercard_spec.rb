require 'oystercard.rb'

describe Oystercard do

	it 'has no money at the beginning' do
		expect(subject.balance).to eq 0
	end

	it 'can top up' do
		expect{ subject.add_money 5 }.to change{ subject.balance }.by 5
	end

	it 'has a balance limit of 90 Pounds' do
		maximum_balance = Oystercard::MAXIMUM_BALANCE
		subject.add_money maximum_balance
		expect{ subject.add_money 1 }.to raise_error 'The balance limit is 90 pounds'
	end
end
