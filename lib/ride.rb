class Ride
  attr_reader :name, :distance, :terrain, :loop
  def initialize(ride_info)
    @name = ride_info[:name]
    @distance = ride_info[:distance].to_f
    @terrain = ride_info[:terrain]
    @loop = ride_info[:loop]
  end

  def loop?
    @loop
  end

  def total_distance
    if @loop == false
      @distance * 2
    else
      @distance
    end
  end
end