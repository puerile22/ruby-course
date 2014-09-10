require 'server_spec_helper'

describe Songify::Server  do
  def app
    Songify::Server.new
  end
  describe 'GET /song_list' do
    it "loads the page which contains the song list" do
      song = Songify::Songs.new(name:'Hello',artist:'None')
      song_1 = Songify::Songs.new(name:'Hi',artist:'World')
      Songify.songs_repo.save(song)
      Songify.songs_repo.save(song_1)
      get '/song_list'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Hello", "Hi"
    end
  end
  describe 'GET /' do
    it "loads the homepage" do
      get '/'
      expect(last_response).to be_ok
      # binding.pry
      #res = last_response.body.split(/\n/).include?("<h1>Welcome to Songify!</h1>")
      #expect(res).to eq(true)
      expect(last_response.body).to include "Welcome to Songify"
    end
  end
  describe 'GET /search_result' do
    it "shows the result of a search" do
      song = Songify::Songs.new(name:'Hello',artist:'None')
      song_1 = Songify::Songs.new(name:'Hi',artist:'World')
      Songify.songs_repo.save(song)
      Songify.songs_repo.save(song_1)
      get "/search_result",{'id'=>2}
      expect(last_response).to be_ok
      expect(last_response.body).to include "World"
    end
  end
  describe 'POST /add_song_s' do
    it "adds a new song to the list" do
      post "/add_song_s",{name:'Ho',artist:"La"}
      expect(last_response).to be_ok
      expect(last_response.body).to include "Ho","La"
    end
  end
end