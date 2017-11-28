class Oystercard
	attr_reader :balance
	MAXIMUM_BALANCE = 90

	def initialize(balance = 0)
		@balance = balance
		@balance_limit = 90
	end

	def top_up(amount)
		raise 'The balance limit is 90 pounds' if balance_full?(amount)
		@balance += amount
	end

	def deduct(amount)
		@balance -= amount
	end
	
	private
	def balance_full?(amount)
		(@balance + amount) > MAXIMUM_BALANCE
	end
end
