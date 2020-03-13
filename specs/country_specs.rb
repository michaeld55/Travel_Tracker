require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative("../db/sqlrunner.rb")
require_relative('../models/country.rb')

class TestCountry < Minitest::Test

  def setup()

    @country1 = Country.new({ "name" => "United Kingdom"})
    @country2 = Country.new({ "name" => "United States of America"})
    @country3 = Country.new({ "name" => "Japan"})
    @country4 = Country.new({ "name" => "Australia"})
    @country5 = Country.new({ "name" => "Egypt"})
    @country6 = Country.new({ "name" => "Brasil"})

  end

  def test_new()

    assert_equal( "United Kingdom", @country1.name )

  end

end
