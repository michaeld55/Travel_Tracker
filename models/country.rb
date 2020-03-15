require_relative( "../db/sqlrunner.rb" )

class Country

  attr_reader( :id )
  attr_accessor( :name )

  def initialize( options )

    # binding.pry()
    @id = options["id"].to_i if options["id"]
    @name = options["name"]

  end

  def save()

    sql = "INSERT INTO countries
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i

  end

  def update

    sql = "UPDATE countries SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )

  end

  def self.find_all()

  sql = "SELECT * FROM countries"
  countries = SqlRunner.run( sql )
  return countries = countries.map { |country| Country.new( country ) }

  end

  def self.find_by_id( id )

  sql = "SELECT * FROM countries WHERE id = $1"
  values = [id]
  country = SqlRunner.run( sql, values ).first
  return country = Country.new( country )

  end

  def self.delete_all()

  sql = "DELETE FROM countries"
  SqlRunner.run( sql )

  end

end
