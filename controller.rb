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
  @trips = Trip.find_all()
  erb(:index)

end

get( "/trips/new" ) do
  @location = Location.new({"country_id" => 0, "continent_id" =>0})
  @trip = Trip.new({"location_id" => 0})
  @countries = Country.find_all
  @continents = Continent.find_all
  erb(:new)

end

get( "/trips/done" ) do
  @trips = Trip.find_all()
  erb(:done)

end

get '/trips/:id/edit' do
  @trip = Trip.find_by_id( params[:id] )
  @location = Location.find_by_id( @trip.location_id )
  @countries = Country.find_all
  @continents = Continent.find_all
  @cities = Destination.find_cities( params[:id] )
 erb(:edit)
end

get '/trips/:id/delete' do

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

  erb(:destroy)

end

post( "/trips" ) do
  @location_continent = Location.find_id_by_country_id( params["country_id"])
  @location = @location_continent[0]
  @continent = @location_continent[1]
  @country = Country.find_by_id( params["country_id"])
  @trip = Trip.find_by_location_id( @location.id )
  if @trip == nil
    @trip = Trip.new({ "location_id" => @location.id})
    @trip.save
  else
    @trip = Trip.find_by_id( @trip.id )
  end

  if "Add Another City" == params["add_new_city"]
    @city = City.new({"name" => params["city_name"], "visited" => false})
    @city.save
    @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
    @destination.save
    @countries = Country.find_all
    @continents = Continent.find_all
    @trip = Trip.find_by_id( @trip.id )
    erb(:new)

  else

    @city = City.new({"name" => params["city_name"], "visited" => false})
    @city.save
    @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
    @destination.save
    @destinations = Destination.find_by_trip_id( @trip.id )
    erb(:create)

  end

end

post("/trips/:id/done") do

  @destinations = Destination.find_by_trip_id( params[:id] )
  @destinations.each do |destination|
    @city = City.find_by_id( destination.city_id )
    @city.visit
    @city.update
  end

  @trips = Trip.find_all
  erb(:done)

end

post( "/trips/:id/update" ) do

    @num_of_cities = params["city_number"].to_i
    if @num_of_cities > 20
      @num_of_cities = 20
    end
    @location_L_C = Location.find_id_by_country_id( params["country_id"])
    @location = @location_L_C[0]
    @continent = @location_L_C[1]
    @country = Country.find_by_id( params["country_id"])
    @trip = Trip.new({"id" => params[:id],"location_id" => @location.id})
    @trip.update

  erb(:edit_cities)

end

post("/trips/:id/change_cities")do
  counter = params.size - 1
  @cities = Destination.find_cities( params[:id])

  @cities.each do |city|
    break if counter == 0
    city1 = City.new( {"id" => (city.id), "name" => params["city_name_#{counter}"], "visited" => city.visited} )
    city1.update
    counter -= 1
  end
  while counter > 1
    city = City.new( {"name" => params["city_name_#{counter}"], "visited" => false} )
    city.save
    destination = Destination.new( {"city_id" => city.id, "trip_id" => params[:id]} )
    destination.save

    counter -= 1
  end
  @trip = Trip.find_by_id( params[:id] )
  @location = Location.find_by_id( @trip.location_id )
  @location_L_C = Location.find_id_by_country_id( @location.country_id )
  @continent = @location_L_C[1]
  @country = Country.find_by_id( @location.country_id )
  @destinations = Destination.find_by_trip_id( params[:id] )

  erb(:create)
end
