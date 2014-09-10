require_relative"../lib/songify.rb"
require 'sinatra/base'
require 'rubygems'
# require 'sinatra'
require 'pry-byebug'

class Songify::Server < Sinatra::Application
  configure do 
    set :bind, '0.0.0.0'
  end

  get '/' do
    erb :home
  end

  get '/song_list' do
    Songify.songs_repo = Songify::Repo::Song_list.new
    @songs = Songify.songs_repo.get_all_song
    erb :list
  end

  get '/search_result' do
    @id = params['id']
    Songify.songs_repo = Songify::Repo::Song_list.new
    @result = Songify.songs_repo.get_song(@id)
    erb :result
  end

  get '/add_song' do
    erb :add
  end

  post '/add_song_s' do 
    puts params
    song = Songify::Songs.new(name:params['name'],artist:params['artist'])
    Songify.songs_repo = Songify::Repo::Song_list.new
    Songify.songs_repo.save(song)
    @name = params['name']
    @artist = params['artist']
    erb :success
  end

run! if app_file == $0
end