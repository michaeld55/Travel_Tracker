require_relative( "../db/sqlrunner.rb" )
require_relative( "city.rb" )

class Destination

    attr_reader( :id )
    attr_accessor( :city_id, :trip_id )

    def initialize( options )

      @id = options["id"].to_i if options["id"]
      @city_id = options["city_id"].to_i
      @trip_id = options["trip_id"].to_i

    end

    def save()

      sql = "INSERT INTO destinations
      (
        city_id, trip_id
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@city_id, @trip_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i

    end

    def update

      sql = "UPDATE destinations SET city_id = $1, trip_id = $2 WHERE id = $3"
      values = [@city_id, @trip_id, @id]
      SqlRunner.run( sql, values )

    end

    def delete()

      sql = "DELETE FROM destinations
      WHERE id = $1"
      values = [@id]
      SqlRunner.run( sql, values )

    end

    def self.find_by_trip_id( trip_id )
      sql = "SELECT * FROM destinations
             WHERE destinations.trip_id = $1"
      values = [trip_id]
      destinations = SqlRunner.run( sql, values )
      destinations = destinations.map{|destination| Destination.new( destination )}

    end

    def self.find_cities( trip_id )

      sql = "SELECT cities.* FROM cities
             INNER JOIN destinations
            ON destinations.city_id = cities.id
            INNER JOIN Trips
            ON destinations.trip_id = trips.id
            WHERE destinations.trip_id = $1"
      values = [trip_id]
      cities = SqlRunner.run( sql, values )
      return cities = cities.map { |city| City.new( city )}

    end

    def self.find_all()

      sql = "SELECT * FROM destinations"
      destinations = SqlRunner.run( sql )
      return destinations = destinations.map { |destination| Destination.new( destination )}

    end

  def self.find_by_id( id )

    sql = "SELECT * FROM destinations WHERE id = $1"
    values = [id]
    destination = SqlRunner.run( sql, values ).first
    return destination = Destination.new( destination )

  end

  def self.delete_all()

    sql = "DELETE FROM destinations"
    SqlRunner.run( sql )

  end

end
