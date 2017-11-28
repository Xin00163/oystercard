require_relative 'journey'

class Oystercard
	attr_reader :balance
	attr_reader :in_journey
	STARTING_BALANCE = 0
	MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

	def initialize(journey = Journey.new)
		@balance = STARTING_BALANCE
		@balance_limit = 90
    @in_journey = false
		@journey = journey
	end

	def top_up(amount)
		raise 'The balance limit is 90 pounds' if balance_full?(amount)
		@balance += amount
	end

	def touch_in
    raise "Insufficient funds" if insufficient_funds?
		@in_journey = true
	end

	def touch_out
		deduct(MINIMUM_FARE)
		@in_journey = false
	end


	private

	def deduct(amount = MINIMUM_FARE)
		@balance -= amount
	end

  def insufficient_funds?
    @balance <= MINIMUM_FARE
  end

	def balance_full?(amount)
		(@balance + amount) > MAXIMUM_BALANCE
	end
end
