require_relative( "db/sqlrunner.rb" )
require_relative( "models/city.rb" )
require_relative( "models/country.rb" )
require( "pry-byebug" )
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


binding.pry()
nil
