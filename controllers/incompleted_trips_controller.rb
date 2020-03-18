require("sinatra")
require("sinatra/contrib/all") if development?
require_relative( "../models/trip.rb" )
require_relative( "../models/location.rb" )
require_relative( "../models/destination.rb" )
require_relative( "../models/country.rb" )
require_relative( "../models/continent.rb" )
require_relative( "../models/city.rb" )
also_reload("./models/*")

get( "/trips" ) do
  @trips = Trip.find_all
  if @trips.size == 0
    Trip.reset_number
  end
  erb(:"incompleted_trips/index")

end

get( "/trips/new" ) do
  @trips = Trip.find_all
  if @trips.size == 0
    Trip.reset_number
  end
  @location = Location.new({"country_id" => 0, "continent_id" =>0})
  @trip = Trip.new({"location_id" => 0})
  @countries = Country.find_all
  @continents = Continent.find_all
  erb(:"incompleted_trips/new")

end

get '/trips/:id/edit' do

  @trip = Trip.find_by_id( params[:id] )
  @location = Location.find_by_id( @trip.location_id )
  @destinations = Destination.find_by_trip_id( params[:id] )
  @countries = Country.find_all
  @continents = Continent.find_all
  @cities = Destination.find_cities( params[:id] )
 erb(:"incompleted_trips/edit")

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

  erb(:"completed_trips/destroy")

end

post( "/trips" ) do

  @location = Location.find_by_country_id( params["country_id"])
  @continent = Continent.find_by_id( @location.continent_id)
  @country = Country.find_by_id( params["country_id"])
  @trip = Trip.new({ "location_id" => @location.id})
  @trip.save
  @destinations = Destination.find_by_trip_id( @trip.id )

  if ("Add Another City" == params["add_new_city"]) && ( @destinations.size <= 19)
    @city = City.new({"name" => params["city_name"], "visited" => false})
    @city.save
    if @city.id != nil
      @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
      @destination.save
    end
    @countries = Country.find_all
    @continents = Continent.find_all
    @trip = Trip.find_by_id( @trip.id )
    @destinations = Destination.find_by_trip_id( @trip.id )
    @cities = Destination.find_cities( @trip.id )
    erb(:"incompleted_trips/edit")

  else

    @city = City.new({"name" => params["city_name"], "visited" => false})
    @city.save
    if @city.id != nil
      @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
      @destination.save
    end
    @destinations = Destination.find_by_trip_id( @trip.id )
    erb(:"incompleted_trips/create")

  end

end

post("/trips/:id/edit")do

  @countries = Country.find_all
  @continents = Continent.find_all
  @location = Location.find_by_country_id( params["country_id"])
  @continent = Continent.find_by_id( @location.continent_id)
  @country = Country.find_by_id( params["country_id"])
  @trip = Trip.new({"id" => params[:id], "location_id" => @location.id})
  @trip.update
  @destinations = Destination.find_by_trip_id( @trip.id )

  if @destinations.size > 20
    @destinations.reverse
    until @destinations.size <= 19
      @destinations.each do |destination|
        destination.delete
      end
    end

  elsif( params["update_trip"] == "Save Trip")

    @destinations.each do |destination|

      if destination.city_id != nil

          @city = City.find_by_id( destination.city_id )

      end

      if @city != nil

        @city = City.new({"id" => @city.id, "name" => params["city_name_#{@city.id}"], "visited" => @city.visited})
        @city.update
        @destination = Destination.new( {"id" => destination.id, "city_id" => @city.id, "trip_id" => @trip.id} )
        @destination.update

      end
    end

      @city = City.new({"name" => params["city_name"], "visited" => false})
      @city.save

      if @city.id != nil

        @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
        @destination.save
      end

      @destinations = Destination.find_by_trip_id( @trip.id )
      erb(:"incompleted_trips/create")

  elsif ( "Add New City" == params["add_new_city"] )

      @city = City.new({"name" => params["city_name"], "visited" => false})
      @city.save

      if @city.id != nil

        @destination = Destination.new( {"city_id" => @city.id, "trip_id" => @trip.id} )
        @destination.save

      end

      @destinations = Destination.find_by_trip_id( @trip.id )
      @cities = Destination.find_cities( @trip.id )
      erb(:"incompleted_trips/edit")
  end
end
