require 'csv'
require './lib/photograph'
require './lib/artist'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs.push(photo)
  end

  def add_artist(artist)
    @artists.push(artist)
  end

  def find_artist_by_id(artist_id)
    @artists.find { |artist| artist.id == artist_id }
  end

  def find_photograph_by_id(photo_id)
    @photographs.find { |photo| photo.id == photo_id }
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all { |photo| artist.id == photo.artist_id }
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).length > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    @photographs.find_all do |photo|
      find_artist_by_id(photo.artist_id).country == country
    end
  end

  def load_photographs(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      @photographs.push(Photograph.new(row.to_h))
    end
  end

  def load_artists(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      @artists.push(Artist.new(row.to_h))
    end
  end

  def photographs_taken_between(range)
    in_range = []
    range.to_a.each do |year|
      in_range += @photographs.find_all { |photo| photo.year.to_i == year }
    end
    in_range
  end

  def artists_photographs_by_age(artist)
    titles_by_age = {}
    find_photographs_by_artist(artist).each do |photo|
      age = photo.year.to_i - artist.born.to_i
      if !titles_by_age[age]
        titles_by_age[age] = photo.name
      else
        titles_by_age[age] = [titles_by_age[age]]
        titles_by_age[age].push(photo.name)
      end
    end
    titles_by_age
  end

end
