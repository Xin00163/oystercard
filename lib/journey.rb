class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    # return unless complete?
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
  end

  private

  def complete?
    !entry_station.nil? && !exit_station.nil?
  end
end
