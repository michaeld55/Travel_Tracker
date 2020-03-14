require("sinatra")
require("sinatra/contrib/all") if development?
require_relative( "db/sqlrunner.rb" )
require_relative( "models/trip.rb" )
require_relative( "models/location.rb" )
require_relative( "models/destination.rb" )
require_relative( "models/country.rb" )
require_relative( "models/continent.rb" )
require_relative( "models/city.rb" )
also_reload("./models/*")

Destination.delete_all()
City.delete_all()

get( "/" ) do
  erb(:home)
end

get( "/trips" ) do
  @trips = Trip.find_all()
  erb(:index)

end

get( "/trips/new" ) do

  @countries = Country.find_all
  @continents = Continent.find_all
  erb(:new)

end

get( "" ) do

end

get( "" ) do

end

get( "" ) do

end

get( "" ) do

end

post( "/trips" ) do

  @city = City.new( {"name" => params["city_name"], "visited" => false} )
  @city.save
  @destination = Destination.new( {"city_id" => @city.id} )
  @destination.save
  @location_L_C = Location.find_id_by_country_id( params["country_id"])
  @location = @location_L_C[0]
  @trip = Trip.new({"location_id" => @location.id, "destination_id" => @destination.id})
  @trip.save
  erb(:create)

end
