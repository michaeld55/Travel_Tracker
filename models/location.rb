require_relative( "country.rb" )

class Location

  attr_reader( :id )
  attr_accessor( :country_id )

  def initialize( options )

    @id = options["id"].to_i if options["id"]
    @country_id = options["country_id"].to_i

  end

  def save()

    sql = "INSERT INTO locations
    (
      country_id
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@country_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i

  end

  def update

    sql = "UPDATE locations SET country_id = $1 WHERE id = $2"
    values = [@country_id, @id]
    SqlRunner.run( sql, values )

  end

  def find_country

    sql = "SELECT * FROM countries
          INNER JOIN locations
          ON locations.country_id = countries.id
          WHERE locations.id = $1"
    values = [@id]
    country = SqlRunner.run( sql, values ).first
    return country = Country.new( country )

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
