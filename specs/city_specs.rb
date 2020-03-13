require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative("../db/sqlrunner.rb")
require_relative('../models/city')

class TestCity < Minitest::Test

  def setup()

    @city1 = City.new({"name" => "Edinburgh", "visited" => false})
    @city2 = City.new({"name" => "New York", "visited" => false})
    @city3 = City.new({"name" => "Tokyo", "visited" => false})
    @city4 = City.new({"name" => "Syndey", "visited" => false})
    @city5 = City.new({"name" => "Cairo", "visited" => false})
    @city6 = City.new({"name" => "Brasilia", "visited" => false})

  end

  def test_new()

    assert_equal( "Edinburgh", @city1.name )
    assert_equal( false, @city1.visited )

  end

  def test_visited()

    @city1.visit
    assert_equal( true, @city1.visited )

  end

end
