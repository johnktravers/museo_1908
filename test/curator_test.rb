require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class ArtistTest < Minitest::Test

  def setup
    create_photos_1_and_2
    create_artists_1_and_2

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



  #-------------Helper Methods-------------#

  def create_photos_1_and_2
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
  end

  def create_artists_1_and_2
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
  end

end
