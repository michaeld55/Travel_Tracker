require_relative("../db/sqlrunner.rb")

class City

  attr_reader( :id )
  # attr_writer

  attr_accessor( :name, :visited )

  def initialize( options )

    @id = options["id"].to_i if options["id"]
    @name = options["name"].downcase.capitalize
    @visited = options["visited"]
  end

  def visit()

    @visited = true

  end

  def save()
    if @name != ""
      sql = "INSERT INTO cities
      (
        name, visited
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@name, @visited]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end
  end

  def update
    if @name != ""

      sql = "UPDATE cities SET name = $1, visited = $2 WHERE id = $3"
      values = [@name, @visited, @id]
      SqlRunner.run( sql, values )
    else
      city = City.new({"id" => @id, "name" => @name, "visited" => @visited, })
      city.delete
    end

  end

  def delete()

    sql = "DELETE FROM cities
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )

  end

  def self.find_all()

    sql = "SELECT * FROM cities"
    cities = SqlRunner.run( sql )
    return cities = cities.map { |city| City.new( city ) }

  end

  def self.find_by_id( id )

    sql = "SELECT * FROM cities WHERE id = $1"
    values = [id]
    city = SqlRunner.run( sql, values ).first
    return city = City.new( city )

  end


  def self.delete_all()

    sql = "DELETE FROM cities"
    SqlRunner.run( sql )

  end

end
