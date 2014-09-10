require_relative 'predictor'
#require 'pry'
class Tfidf < Predictor
  def train!
    @data={}
    #@final={}
    @idf=Hash.new(0)
    @all_books.each do |category,books|
      @data[category]=Hash.new(0)
      books.each do |filename,tokens|
        tokens.each do |word|
          @data[category][word]+=1 if good_token?(word)
        end
      end
    end
       #binding.pry
    @most_count=0
    @data.each do |category,words|
      @most_count=words.values.max
      words.each do |word,times|
        words[word]=times/@most_count.to_f
        @idf[word]=calculate_idf(word)
      end
    end
    @data.each do |category,words|
      words.each do |word,i|
        words[word]=i*@idf[word]
      end
    end
    #@data.each do |category,words|
    #  @final[category]=Hash.new(0)
    #  @final[category]=Hash[words.sort_by{|k,v| v}.reverse[0..19]]
    #end
    #@data.each do |category,words|
     # words.each do |word,x|
     #   @idf[word]=calculate_idf(word) 
     # end
    #end
    #binding.pry
  end

  def calculate_idf(word)
    count=0
    @data.each do |category,words|
      if words[word]!=0
        count+=1
      end
    end
    return Math.log(4/count.to_f)
  end

  def predict(tokens)
    @words=Hash.new(0)

    @data.each do |category,words|
      @words[category]=0
      tokens.each do |word|
        #@words[category]+=words[word]*@idf[word] if words[word] !=0 && @idf[word] !=0
        @words[category]+=words[word] if words[word]!=0
      end
    end
    Hash[@words.sort_by{|k,v| v}.reverse].keys.first
  end
end
