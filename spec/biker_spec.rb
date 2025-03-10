require './lib/ride'
require './lib/biker'
require "pry"

RSpec.describe Ride do
  before :each do
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
  end

  describe "biker exist and attributes" do
    it "exist and has attributes" do
      expect(@biker1).to be_a(Biker)
      expect(@biker1.name).to eq("Kenny")
      expect(@biker1.max_distance).to eq(30)
      expect(@biker1.rides).to eq({})
      expect(@biker1.acceptable_terrain).to eq([])
      

    end
  end
  describe "what i biker can do" do 
    it "can lean terrain" do
      expect(@biker1.acceptable_terrain).to eq([])

      @biker1.learn_terrain(:gravel)
      @biker1.learn_terrain(:hills)
      

      expect(@biker1.acceptable_terrain).to eq([:gravel, :hills])
    end

    it "can log rides" do
      ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

      @biker1.log_ride(ride1, 92.5)
      @biker1.log_ride(ride1, 91.1)
      @biker1.log_ride(ride2, 60.9)
      @biker1.log_ride(ride2, 61.6)
     
      expected = {
        ride1 => [92.5, 91.1],
        ride2 => [60.9, 61.6]
        }
      expect(@biker1.rides).to eq(expected)
    end
    it "has a personal recored" do
      ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

      @biker1.log_ride(ride1, 92.5)
      @biker1.log_ride(ride1, 91.1)
      @biker1.log_ride(ride2, 60.9)
      @biker1.log_ride(ride2, 61.6)
      @biker2.log_ride(ride1, 97.0)
      @biker2.log_ride(ride2, 67.0)

      expect(@biker1.personal_recored(ride1)).to eq(91.1)
      expect(@biker1.personal_recored(ride2)).to eq(60.9)
    end
    it "has another biker" do
      ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
      
      expect(@biker2.rides).to eq({})

      @biker2.log_ride(ride1, 97.0)
      @biker2.log_ride(ride1, 95.0)
      @biker2.log_ride(ride2, 67.0)
      @biker2.log_ride(ride2, 65.0)


      expect(@biker2.acceptable_terrain).to eq([])

      @biker2.learn_terrain(:gravel)
      @biker2.learn_terrain(:hills)
      
      expect(@biker2.acceptable_terrain).to eq([:gravel, :hills])
      expected = {
        ride1 => [97.0, 95.0],
        ride2 => [67.0, 65.0]
        }
      expect(@biker2.rides).to eq(expected)
      expect(@biker2.personal_recored(ride1)).to eq(false)
      expect(@biker2.personal_recored(ride2)).to eq(65.0)

    end
  end
end  