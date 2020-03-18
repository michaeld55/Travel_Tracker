require_relative( "../db/sqlrunner.rb" )

class Trip

    attr_reader( :id )
    attr_accessor( :location_id )

    def initialize( options )

      @id = options["id"].to_i if options["id"]
      @location_id = options["location_id"].to_i

    end

    def save()

      sql = "INSERT INTO trips
      (
        location_id
      )
      VALUES
      (
        $1
      )
      RETURNING id"
      values = [@location_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i

    end

    def update

      sql = "UPDATE trips SET location_id = $1 WHERE id = $2"
      values = [@location_id, @id]
      SqlRunner.run( sql, values )

    end

    def find_country_cities

      location = Location.find_by_id( @location_id )
      country = location.find_country
      cities = Destination.find_cities( @id )
      result = [country]
      cities.each do |city|
        result.push( city )
      end
      return result

    end

    def self.find_done( id )
      sql = "SELECT * FROM Trips
             INNER JOIN destinations
             ON destinations.trip_id = trips.id
             INNER JOIN cities
             ON destinations.city_id = cities.id
             WHERE cities.visited = TRUE AND trips.id = $1"
      values = [id]
      cities = SqlRunner.run( sql, values )
      @cities = cities.map { |city| City.new( city ) }

    end

    def self.find_not_done( id )
      sql = "SELECT * FROM Trips
             INNER JOIN destinations
             ON destinations.trip_id = trips.id
             INNER JOIN cities
             ON destinations.city_id = cities.id
             WHERE cities.visited = FALSE AND trips.id = $1"
      values = [id]
      cities = SqlRunner.run( sql, values )
      @cities = cities.map { |city| City.new( city ) }

    end

    def self.find_all()

      sql = "SELECT * FROM trips"
      trips = SqlRunner.run( sql )
      return trips = trips.map { |trip| Trip.new( trip )}

    end

    def self.find_by_id( id )

      sql = "SELECT * FROM trips WHERE id = $1"
      values = [id]
      trip = SqlRunner.run( sql, values ).first
      return trip = Trip.new( trip )

    end

    def self.find_by_location_id( location_id )


      sql = "SELECT * FROM trips WHERE location_id = $1"
      values = [location_id]
      trip = SqlRunner.run( sql, values ).first

      if trip != nil
        return trip = Trip.new( trip )
      else
        return nil
      end
    end

    def delete()

      sql = "DELETE FROM trips
      WHERE id = $1"
      values = [@id]
      SqlRunner.run( sql, values )

    end

    def self.delete_all()

      sql = "DELETE FROM trips"
      SqlRunner.run( sql )

    end
end
