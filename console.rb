require_relative( "db/sqlrunner.rb" )
require_relative( "models/trip.rb" )
require_relative( "models/location.rb" )
require_relative( "models/destination.rb" )
require_relative( "models/city.rb" )
require_relative( "models/country.rb" )
require( "pry-byebug" )


Destination.delete_all
Trip.delete_all
City.delete_all



city1 = City.new({"name" => "Edinburgh", "visited" => false})
city2 = City.new({"name" => "New York", "visited" => false})
city3 = City.new({"name" => "Tokyo", "visited" => false})
city4 = City.new({"name" => "Syndey", "visited" => false})
city5 = City.new({"name" => "Cairo", "visited" => false})
city6 = City.new({"name" => "Brasilia", "visited" => false})

city1.save
city2.save
city3.save
city4.save
city5.save
city6.save

locations = Location.find_all

location = locations.first

trip1 = Trip.new({"location_id" => location.id})
trip1.save

destination1 = Destination.new({"trip_id" => trip1.id, "city_id" => city1.id})
destination1.save

destination2 = Destination.new({"trip_id" => trip1.id, "city_id" => city2.id})
destination2.save

destination3 = Destination.new({"trip_id" => trip1.id, "city_id" => city1.id})
destination3.save





binding.pry()
nil
