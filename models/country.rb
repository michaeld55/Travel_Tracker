class Country

  attr_reader()
  attr_accessor()

  def initialize( options )
    @id = options["id"].to_i if options['id']
    @name = options[:name]

  end

end
