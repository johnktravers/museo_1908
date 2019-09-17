require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'

class CuratorTest < Minitest::Test

  def setup
    create_photos
    create_artists

    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_initialize
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_add_photograph
    @curator.add_photograph(@photo_1)
    assert_equal [@photo_1], @curator.photographs

    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_add_artist
    @curator.add_artist(@artist_1)
    assert_equal [@artist_1], @curator.artists

    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_find_artist_by_id
    add_artists

    assert_equal @artist_3, @curator.find_artist_by_id("3")
  end

  def test_find_photograph_by_id
    add_photos

    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_find_photographs_by_artist
    add_artists
    add_photos

    assert_equal [@photo_2], @curator.find_photographs_by_artist(@artist_2)

    expected = [@photo_3, @photo_4]
    assert_equal expected, @curator.find_photographs_by_artist(@artist_3)
  end

  def test_artists_with_multiple_photographs
    add_artists
    add_photos

    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_photographs_taken_by_artist_from
    add_artists
    add_photos

    assert_equal [@photo_1], @curator.photographs_taken_by_artist_from("France")
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")

    expected = [@photo_2, @photo_3, @photo_4]
    assert_equal expected, @curator.photographs_taken_by_artist_from("United States")
  end

  def test_load_photographs
    @curator.load_photographs('./data/photographs.csv')

    assert_equal 4, @curator.photographs.length
    assert_instance_of Photograph, @curator.photographs[3]
    assert_equal "4", @curator.photographs[3].id
    assert_equal "Child with Toy Hand Grenade in Central Park", @curator.photographs[3].name
    assert_equal "3", @curator.photographs[3].artist_id
    assert_equal "1962", @curator.photographs[3].year
  end


  #-------------Helper Methods-------------#

  def create_photos
    @photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    @photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    @photo_3 = Photograph.new({
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    })
    @photo_4 = Photograph.new({
      id: "4",
      name: "Monolith, The Face of Half Dome",
      artist_id: "3",
      year: "1927"
    })
  end

  def create_artists
    @artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    @artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    @artist_3 = Artist.new({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })
  end

  def add_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
  end

  def add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
  end

end
