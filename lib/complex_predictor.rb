require_relative 'predictor'
require 'pry'
class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
  def train!
    @data = {}
    @big_data={}
    @word_frequency=Hash.new(0)
    @most_frequent_word={}  
    @sd={}  
    @all_books.each do |category, books|
      @data[category]={}
      books.each do |filename, tokens|
        tokens.each do |word|
          @word_frequency[word]+=1 if good_token?(word)
        end
        #@data[category][filename][:words] += tokens.count
        @word_frequency.each do |word,count|
          @word_frequency[word]=count/tokens.count.to_f
        end
        @most_frequent_word=Hash[@word_frequency.sort_by{|k,v| v}.reverse[0..99]]
        @data[category][filename] = @most_frequent_word
        #binding.pry
        @word_frequency=Hash.new(0)
        @most_frequent_word={}
      end
    end
    #binding.pry
    @data.each do |category,x|
      @sd[category]= Hash.new([])
      #@super_data=Hash.new(0)
      @super_data=[]
      @big_data[category] = {}
      x.each do |filename,word_freq|
        word_freq.each do |word,freq|
          @sd[category][word]=[] if @sd[category][word]==[]
          @sd[category][word]<<freq
          #@super_data[word] += freq
        end
      end
      @sd[category].each do |word,freqs|
        @super_data<<{word=>freqs} if freqs.length > 4
        break if @super_data.count>60
      #@super_data.each do |k,v|
        #@super_data[k] = v/x.count
      end
      @super_data.each do |pair|
        pair.each do |word,freqs|
          avg=freqs.inject(:+)/freqs.count.to_f
          sum=0
          freqs.each do |i|
            sum+=(i-avg)**2
        end
          sd=Math.sqrt(sum/(freqs.count-1).to_f)
          @big_data[category][word]=[avg,sd]
        end
      end

      #@big_data[category] = Hash[@super_data.sort_by{|k,v| v}.reverse[0..99]]
    end
      #binding.pry
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    @word_frequency=Hash.new(0)
    #(0..tokens.length/10).each do |i|
    #  @word_frequency[tokens[i]]+=1/tokens.length.to_f/10
    #end
    tokens.each do |word|
      @word_frequency[word]+=1/tokens.length.to_f if good_token?(word)
    end
    #binding.pry

    list={}
    #@data[category][filename][:words] += tokens.count
    @big_data.each do |category,words|
      count=0
      words.each do |word,stats|
        if @word_frequency[word]!=0 && (@word_frequency[word]>=stats[0]-2*stats[1] && @word_frequency[word]<=stats[0]+2*stats[1])
          count+=1
        end
      end
      list[category]=count
      #binding.pry
        #return category if count>words.length/2
    end

    Hash[list.sort_by{|k,v| v}.reverse].keys.first
  end
end

