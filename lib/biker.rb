class Biker
  attr_reader :name, :max_distance, :rides, :acceptable_terrain
  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = Hash.new
    @acceptable_terrain = []
  end

  def learn_terrain(terrain)
    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    if @acceptable_terrain.include?(ride.terrain) && ride.distance <= @max_distance
      @rides[ride] << time
    else
      @rides[ride] = [time]
      binding.pry
    end
  end
  
  def personal_recored(ride)
    if @rides.key?(ride) 
      @rides[ride].min
    else
      false
    end
  end
end
