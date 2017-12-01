class JourneyLog
  attr_reader :current_journey, :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new(station)
  end

  def finish(station)
    @current_journey.end_journey(station)
    @journeys << @current_journey
  end

  def charge
    @current_journey.fare
  end

  def reset
    @current_journey = nil
  end
end
