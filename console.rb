require_relative( "db/sqlrunner.rb" )
require_relative( "models/trip.rb" )
require_relative( "models/location.rb" )
require_relative( "models/destination.rb" )
require_relative( "models/city.rb" )
require_relative( "models/country.rb" )
require( "pry-byebug" )

Trip.delete_all
Destination.delete_all
Location.delete_all
City.delete_all
Country.delete_all


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

# city1.name = "London"
# city1.update
#
# city1.visit
# city1.update

country1 = Country.new({ "name" => "United Kingdom"})
country2 = Country.new({ "name" => "United States of America"})
country3 = Country.new({ "name" => "Japan"})
country4 = Country.new({ "name" => "Australia"})
country5 = Country.new({ "name" => "Egypt"})
country6 = Country.new({ "name" => "Brasil"})

country1.save
country2.save
country3.save
country4.save
country5.save
country6.save

# country1.name = "England"
# country1.update

location1 = Location.new({"country_id" => country1.id})
location1.save

destination1 = Destination.new({"city_id" => city1.id})
destination1.save

location2 = Location.new({"country_id" => country1.id})
location2.save

destination2 = Destination.new({"city_id" => city2.id})
destination2.save

location3 = Location.new({"country_id" => country3.id})
location3.save

destination3 = Destination.new({"city_id" => city1.id})
destination3.save


trip1 = Trip.new({"location_id" => location1.id, "destination_id" => destination1.id})
trip1.save

trip2 = Trip.new({"location_id" => location2.id, "destination_id" => destination2.id})
trip2.save

trip3 = Trip.new({"location_id" => location3.id, "destination_id" => destination3.id})
trip3.save

binding.pry()
nil
