require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

class Oystercard
	attr_reader :balance, :entry_station, :journey_log
	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90


	def initialize (balance = DEFAULT_BALANCE, journey_log = JourneyLog.new)
		@balance = balance
		@journey_log = journey_log
	end

	def top_up(amount)
		raise 'The balance limit is 90 pounds' if balance_full?(amount)
		@balance += amount
	end


	def touch_in(station)
    raise "Insufficient funds" if insufficient_funds?
		reset_journey if journey_log.current_journey != nil
		journey_log.start(station)
		self
	end

	def touch_out(station)
		journey_log.start(nil) if !journey_log.current_journey
		journey_log.finish(station)
		deduct_fare(journey_log.charge)
		journey_log.reset
		self
	end

	private

	def deduct_fare(fare)
		@balance -= fare
	end

	def insufficient_funds?
		@balance < Journey::MINIMUM_FARE
	end

	def balance_full?(amount)
		(@balance + amount) > MAXIMUM_BALANCE
	end

	def reset_journey
		journey_log.finish(nil)
		deduct_fare(journey_log.charge)
	end
end
