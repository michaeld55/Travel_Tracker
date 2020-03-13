require_relative( "db/sqlrunner.rb" )
require_relative( "models/city.rb" )
require_relative( "models/country.rb" )
require( "pry-byebug" )

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

city1.name = "London"
city1.update

city1.visit
city1.update

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

country1.name = "England"
country1.update

binding.pry()
nil
