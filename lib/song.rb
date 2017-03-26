require 'pry'

class Song
  attr_accessor :name, :artist_name

  @@all = []

  def initialize(name)
    @name = name
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self ####self.class.all is same as @@all... it's a song instance, calling the class, Song, on the .all method, which returns @@all
  end

  def self.create
    new_song = Song.new(name)
    all << new_song
    new_song
  end

  def self.new_by_name(name)
    new_song = Song.new(name)
  end

  def self.create_by_name(name)
    new_song = Song.new(name)
    all << new_song
    new_song
  end

  def self.create_by_name_and_artist(name, artist_name)
    new_song = Song.new(name, artist_name)
    all << new_song
    new_song
  end

  #refactoring:::
  def self.find_by_name(name)
    all.select do |song_name|
      song_name.name == name
    end.first
  end

  ####this works, refactored above with select
  # def self.find_by_name(name)
  #   array = []
  #   all.each do |song_name|
  #     if song_name.name == name
  #       array << song_name
  #     end
  #   end
  #   array.first
  # end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name) #find by name (if it exists)... OR create by name (if left side of || is false, and song doesn't exist)
  end

  def self.alphabetical
    all.sort_by do |object|
      object.name #sorting just the names of the objects, not the object IDS
    end
  end

  def self.new_from_filename(filename)
    #binding.pry
    brand_new_song = Song.new(name)
    #brand_new_song = #<Song:0x007fc236a33f40 @name="Song">

    #filename = "Thundercat - For Love I Come.mp3"
    new_song = filename.split(' - ')
    #new_song = ["Thundercat", "For Love I Come.mp3"]

    artist_name = new_song.first
    #artist_name = "Thundercat"

    name = new_song.last
    #name.last = "For Love I Come.mp3"
    name = name.split('.')
    #name = ["For Love I Come", "mp3"]
    name = name.first
    #"For Love I Come"

    brand_new_song.name = name #assign name "For Love I Come" to brand_new_song
    brand_new_song.artist_name = artist_name #assign artist_name "Thundercat" to artist_name
    brand_new_song
  end

  def self.create_from_filename(filename)
    brand_new_song = self.new_from_filename(filename)
    all << brand_new_song
    brand_new_song
  end

  def self.destroy_all
    all.clear
  end

end
