class Oystercard
	attr_reader :balance
	attr_reader :in_journey
	MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

	def initialize(balance = 0)
		@balance = balance
		@balance_limit = 90
    @in_journey = false
	end

	def top_up(amount)
		raise 'The balance limit is 90 pounds' if balance_full?(amount)
		@balance += amount
	end

	def deduct(amount)
		@balance -= amount
	end

	def touch_in
    raise "Insufficient funds" if insufficient_funds?
		@in_journey = true
	end

	def touch_out
		@in_journey = false
	end

	private
  def insufficient_funds?
    @balance <= MINIMUM_FARE
  end

	def balance_full?(amount)
		(@balance + amount) > MAXIMUM_BALANCE
	end
end
