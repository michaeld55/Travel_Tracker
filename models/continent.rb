require_relative( "../db/sqlrunner.rb" )

class Continent

  attr_reader( :id )
  attr_accessor( :name )

  def initialize( options )

    # binding.pry()
    @id = options["id"].to_i if options["id"]
    @name = options["name"]

  end

  def save()

    sql = "INSERT INTO continents
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

    sql = "UPDATE continents SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )

  end

  def self.find_all()

  sql = "SELECT * FROM continents"
  continents = SqlRunner.run( sql )
  return continents = continents.map { |continent| Continent.new( continent ) }

  end

  def self.find_by_id( id )

  sql = "SELECT * FROM continents WHERE id = $1"
  values = [id]
  continent = SqlRunner.run( sql, values ).first
  return continent = Continent.new( continent )

end

  def self.delete_all()

  sql = "DELETE FROM continents"
  SqlRunner.run( sql )

  end

end
