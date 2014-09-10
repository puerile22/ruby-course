require_relative "../spec_helper.rb"

describe Songify::Songs do 
  describe '#initialize' do 
    it "create a new instance of Songs class" do
      song = Songify::Songs.new(name:'Hello',artist:'None')
      expect(song.name).to eq('Hello')
    end
  end
  describe '#update' do
    it "update the info of a song" do
      song = Songify::Songs.new(name:'Hello',artist:'None')
      song.update(name:'hi')
      expect(song.name).to eq('hi')
      expect(song.artist).to eq('None')
    end
  end
end