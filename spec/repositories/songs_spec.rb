require_relative "../spec_helper.rb"

describe Songify::Repo do
  let(:repo) {Songify::Repo::Song_list.new}
  let(:song) {Songify::Songs.new(name:'Hello',artist:'World')}
  before (:each) do
    repo.drop_table
    repo.create_table
    repo.save(song)
  end
  describe "#save" do
    it 'saves a new song to the database' do
      expect(song.id).to eq(1)
    end
    it "updates a song's name and/or artist" do
      song.update(name:'hi')
      result = repo.save(song)
      expect(result.name).to eq('hi')
      expect(result.id).to eq(1)
    end
  end
  describe "#get_song" do
    it "gets a song by its id" do
      expect(repo.get_song(1).first.name).to eq('Hello')
    end
  end
  describe '#get_all_song' do
    it "gets all the songs from the list" do
      song_1=Songify::Songs.new(name:'hi',artist:'none')
      repo.save(song_1)
      result = repo.get_all_song
      expect(result.first.name).to eq('Hello')
      expect(result.last.artist).to eq('none')
    end
  end
  describe '#delete_song' do
    it "delete a song by its id" do
      repo.delete_song(1)
      expect(repo.get_all_song).to be_nil
    end
  end

end