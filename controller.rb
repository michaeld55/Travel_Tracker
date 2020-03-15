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

get( "/" ) do
  erb(:home)
end

get( "/trips" ) do
  @trips = Trip.find_not_done()
  erb(:index)

end

get( "/trips/new" ) do
  @cites = []
  @countries = Country.find_all
  @continents = Continent.find_all
  erb(:new)

end

get( "/trips/done" ) do
  @trips = Trip.find_done
  erb(:done)

end

get '/trips/:id/edit' do
  @trip = Trip.find_by_id(params[:id])
  @countries = Country.find_all
  @continents = Continent.find_all
 erb(:edit)
end

get '/trips/:id/delete' do

  @trip = Trip.find_by_id( params[:id] )
  @location = Location.find_by_id( @trip.location_id )
  @country = Country.find_by_id( @location.country_id )
  @destinations = Destination.find_by_trip_id( params[:id] )
  @destination = @destinations.first
  @city = City.find_by_id( @destination.id )
  @destination.delete
  @trip.delete
  @city.delete

  erb(:destroy)

end



get( "" ) do

end

post( "/trips" ) do
  # @cites.each do |city|
    @city = City.new( {"name" => params["city_name"], "visited" => false} )
    @city.save
  # end
  @location_L_C = Location.find_id_by_country_id( params["country_id"])
  @location = @location_L_C[0]
  @continent = @location_L_C[1]
  @country = Country.find_by_id( params["country_id"])
  @trip = Trip.new({"location_id" => @location.id})
  @trip.save
  @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
  @destination.save
  erb(:create)

end

post("/trips/:id/done") do

  @destinations = Destination.find_by_trip_id( params[:id] )
  @destination = @destinations.first
  @city = City.find_by_id( @destination.city_id )
  @city.visit
  @city.update
  @trips = Trip.find_done
  erb(:done)

end

post( "/trips/:id/update" ) do

  @destinations = Destination.find_by_trip_id( params[:id] )
  @destination = @destinations.first
  @city = City.new("id" => @destination.city_id, "name" => params["city_name"], "visited" => false)
  @city.update
  @location_L_C = Location.find_id_by_country_id( params["country_id"])
  @location = @location_L_C[0]
  @continent = @location_L_C[1]
  @country = Country.find_by_id( params["country_id"])
  @trip = Trip.new({"id" => params[:id], "location_id" => @location.id})
  @trip.update
  erb(:create)

end
