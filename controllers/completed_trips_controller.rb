require("sinatra")
require("sinatra/contrib/all") if development?
require_relative( "../models/trip.rb" )
require_relative( "../models/location.rb" )
require_relative( "../models/destination.rb" )
require_relative( "../models/country.rb" )
require_relative( "../models/continent.rb" )
require_relative( "../models/city.rb" )
also_reload("./models/*")

get( "/completed_trips/" ) do
  @trips = Trip.find_all()
  erb(:"completed_trips/index")

end

get '/completed_trips/:id/delete' do

  @trip = Trip.find_by_id( params[:id] )
  @destinations = Destination.find_by_trip_id( params[:id] )
  @location = Location.find_by_id( @trip.location_id )
  @country = Country.find_by_id( @location.country_id )

  @destinations.each do |destination|
    city = City.find_by_id( destination.city_id )
    destination.delete
    city.delete
  end
    @trip.delete

  erb(:"incompleted_trips/destroy")

end

post("/completed_trips/:id/update") do

  @destinations = Destination.find_by_trip_id( params[:id] )

  @destinations.each do |destination|
    @city = City.find_by_id( destination.city_id )
    @city.visit
    @city.update
  end

  @trips = Trip.find_all
  erb(:"completed_trips/index")

end
