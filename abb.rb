require( "sinatra" )
require( "sinatra/contrib/all" )
require_relative( "db/sqlrunner.rb" )
require_relative( "controllers/completed_trips_controller.rb" )
require_relative( "controllers/incompleted_trips_controller.rb" )

get( "/" ) do

  erb(:home)
end
