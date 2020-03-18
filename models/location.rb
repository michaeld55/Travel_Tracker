require_relative( "../db/sqlrunner.rb" )
require_relative( "country.rb" )
require_relative( "continent.rb" )

class Location

  attr_reader( :id )
  attr_accessor( :country_id, :continent_id )

  def initialize( options )

    @id = options["id"].to_i if options["id"]
    @country_id = options["country_id"].to_i
    @continent_id = options["continent_id"].to_i

  end

  def save()

    sql = "INSERT INTO locations
    (
      country_id, continent_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@country_id, @continent_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i

  end

  def update

    sql = "UPDATE locations SET country_id = $1, continent_id = $2 WHERE id = $3"
    values = [@country_id, @continent_id, @id]
    SqlRunner.run( sql, values )

  end

  def find_country

    sql = "SELECT * FROM countries
          INNER JOIN locations
          ON locations.country_id = countries.id
          WHERE locations.id = $1"
    values = [@id]
    country = SqlRunner.run( sql, values ).first
    country = Country.new( country )
    return country
  end

  def self.find_by_country_id( country_id )

    sql = "SELECT locations.id, locations.continent_id FROM locations
           LEFT JOIN countries
           ON locations.country_id = countries.id
           RIGHT JOIN continents
           ON locations.continent_id = continents.id
           WHERE countries.id = $1"

    values = [ country_id ]
    location = SqlRunner.run( sql, values ).first
    location = ( Location.find_by_id( location["id"] ))
    location
  end

  def self.find_all()

  sql = "SELECT * FROM locations"
  locations = SqlRunner.run( sql )
  return locations = locations.map { |location| Location.new( location ) }

  end

  def self.find_by_id( id )

  sql = "SELECT * FROM locations WHERE id = $1"
  values = [id]
  location = SqlRunner.run( sql, values ).first
  return location = Location.new( location )

end

  def self.delete_all()

  sql = "DELETE FROM locations"
  SqlRunner.run( sql )

  end

end
