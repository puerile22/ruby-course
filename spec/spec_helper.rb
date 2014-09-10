require 'rspec'
require 'pry-byebug'
require 'pg'
require_relative '../lib/songify.rb'
Songify.songs_repo = Songify::Repo::Song_list.new

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs_repo.drop_table
    Songify.songs_repo.create_table
  end
end