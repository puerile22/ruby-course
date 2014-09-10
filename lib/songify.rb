require 'pg'
module Songify
  def self.songs_repo=(repo)
    @songs_repo = repo
  end
  def self.songs_repo
    @songs_repo
  end
end


require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/songs.rb'