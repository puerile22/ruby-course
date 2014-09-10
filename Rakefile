task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end

task :drop_table do
  #require './lib/songify.rb'
  `DROP TABLE IF EXISTS song_list`
end

task :create_table do
  `CREATE TABLE song_list`
end