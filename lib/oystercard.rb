require_relative 'journey'

class Oystercard
	attr_reader :balance
	attr_reader :entry_station
	attr_reader :exit_station
	STARTING_BALANCE = 0
	MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

	def initialize(journey = Journey.new)
		@balance = STARTING_BALANCE
		@balance_limit = 90
		@journey = journey
	end

	def top_up(amount)
		raise 'The balance limit is 90 pounds' if balance_full?(amount)
		@balance += amount
	end

	def touch_in(station)
    raise "Insufficient funds" if balance < MINIMUM_FARE
		@in_journey = true
		@entry_station = station
	end

	def touch_out(station)
		deduct(MINIMUM_FARE)
		@entry_station = nil
		@exit_station = station #Not in journey any more.
	end

	def in_journey?
		!!entry_station
	end

	private

	def deduct(amount = MINIMUM_FARE)
		@balance -= amount
	end


	def balance_full?(amount)
		(@balance + amount) > MAXIMUM_BALANCE
	end
end
