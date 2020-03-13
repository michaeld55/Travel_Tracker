class Trip

    attr_reader( :id )
    attr_accessor( :location_id, :destination_id )

    def initialize( options )

      @id = options["id"].to_i if options["id"]
      @location_id = options["location_id"].to_i
      @destination_id = options["destination_id"].to_i

    end

    def save()

      sql = "INSERT INTO trips
      (
        location_id, destination_id
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@location_id, @destination_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i

    end

    def update

      sql = "UPDATE trips SET location_id = $1, destination_id = $2 WHERE id = $3"
      values = [@location_id, @destination_id, @id]
      SqlRunner.run( sql, values )

    end

    def find_location_destination

      location = Location.find_by_id( location_id )
      destination = Destination.find_by_id( destination_id )
      country = location.find_country
      city = destination.find_city
      return "You want to go to #{country.name} and visit #{city.name}"
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

    def self.delete_all()

    sql = "DELETE FROM trips"
    SqlRunner.run( sql )

    end
end
