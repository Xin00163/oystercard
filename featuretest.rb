require './lib/oystercard'
require './lib/journey'

# parts 4-5
# new oyster card
# p oyster = Oystercard.new
# # should display a balance of 0
# # p oyster.balance
# # # add some money
# # p oyster.top_up(5)
# # balance should now return 5
# # p oyster.balance
#
# # part 6
# # p 'expect an error message when adding 91'
# # p 'pounds to the oyster card because the limit is 90'
# # p oyster.top_up(91)
#
# #part 7
# #deduct money
# # p oyster.deduct(4)
# # p oyster.balance
#
# #part 8
# # p oyster.in_journey?
# # p oyster.touch_in
# # p oyster.touch_out
#
# #part 9
# # p 'expect an error message when insufficient funds'
# # p oyster.touch_in
# # p 'insufficient funds'
#
# #part10
# oyster.top_up(5)
# # p oyster.touch_in
# # p oyster.touch_out
# # p oyster.deduct(2)
# # p oyster.balance == 3
#
# # #part 11
# # p journey = Journey.new
# # p journey
# # p oyster.touch_in(station)
#
# # part 12
# oyster.touch_in(station)
# oyster.touch_out(station)
#
# # # part 13
# p station = Station.new("Victoria", "1")
# p station.name
# p station.zone
