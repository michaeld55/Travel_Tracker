require( "sinatra" )
require( "sinatra/contrib/all" )
require_relative( "db/sqlrunner.rb" )
require_relative( "controllers/completed_trips_controller.rb" )
require_relative( "controllers/incompleted_trips_controller.rb" )

get( "/" ) do
  @trips = Trip.find_all
  if @trips.size == 0
    Trip.reset_number
  end
  erb(:home)
end
