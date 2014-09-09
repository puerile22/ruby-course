module Songify
  class Songs
    attr_reader :name,:id,:artist
    def initialize(params)
      @name = params[:name]
      @artist = params[:artist]
      @id = params[:id]
    end
    def update(params)
      @name = params[:name] if !params[:name].nil?
      @artist = params[:artist] if !params[:artist].nil?
    end
  end
end