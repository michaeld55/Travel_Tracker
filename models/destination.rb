require_relative( "city.rb" )

class Destination

    attr_reader( :id )
    attr_accessor( :city_id)

    def initialize( options )

      @id = options["id"].to_i if options["id"]
      @city_id = options["city_id"].to_i

    end

    def save()

      sql = "INSERT INTO destinations
      (
        city_id
      )
      VALUES
      (
        $1
      )
      RETURNING id"
      values = [@city_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i

    end

    def update

      sql = "UPDATE destinations SET city_id = $1 WHERE id = $2"
      values = [@city_id, @id]
      SqlRunner.run( sql, values )

    end

    def find_city

      sql = "SELECT * FROM cities
            INNER JOIN destinations
            ON destinations.city_id = cities.id
            WHERE destinations.id = $1"
      values = [@id]
      city = SqlRunner.run( sql, values ).first
      return city = City.new( city )

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
