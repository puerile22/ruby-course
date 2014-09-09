module Songify
  module Repo
    class Song_list
      def initialize
        @db=PG.connect(host:'localhost',dbname:'songify-db')
      end
      def save(song)
        if song.id.nil?
          sql = "INSERT INTO song_list(name,artist) VALUES($1,$2) returning id"
          result = @db.exec(sql,[song.name,song.artist])
          song.instance_variable_set('@id',result[0]['id'].to_i)
        else
          sql = "UPDATE song_list SET name=$1,artist=$2 WHERE id=$3 returning *"
          result = @db.exec(sql,[song.name,song.artist,song.id])
          Songify::Songs.new(name:result[0]['name'],artist:result[0]['artist'],id:result[0]['id'].to_i)
        end
      end
      def get_song(id)
        sql = "SELECT * FROM song_list WHERE id='#{id}'"
        result = @db.exec(sql)
        if result.to_a !=[]
          result.map do |row|
            entity(row)
          end
        end
        #Songify::Songs.new(name:result[0]['name'],artist:result[0]['artist'],id:result[0]['id'])
      end
      def get_all_song
        sql = "SELECT * FROM song_list"
        result = @db.exec(sql)
        if result.to_a != []
          result.map do |row|
            entity(row)
          end
        end
      end
      def entity(song)
          Songify::Songs.new(name:song['name'],artist:song['artist'],id:song['id'].to_i)
      end
      def delete_song(id)
        sql = "DELETE FROM song_list WHERE id='#{id}'"
        result = @db.exec(sql)
      end
      def drop_table
        sql = "DROP TABLE IF EXISTS song_list"
        result = @db.exec(sql)
      end
      def create_table
        sql = "CREATE TABLE song_list(id SERIAL PRIMARY KEY,name text, artist name)"
        result = @db.exec(sql)
      end
    end
  end
end