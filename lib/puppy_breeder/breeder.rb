#Refer to this class as PuppyBreeder::Breeder
module PuppyBreeder
  class Breeder
  	attr_reader :name
  	attr_accessor :puppy_list,:puppy,:purchase_request,:completed_request,:purchase_list,:on_hold_request
    
    @@all_breed={
      'Hound'=>1000,'Japanese chin'=>500,'Harrier'=>600,'Alaskan'=>700
    }

  	def initialize(name)
  		@name=name
  		@puppy_list={}
  		@purchase_request={}
  		@completed_request={}
      @purchase_list = PuppyBreeder::Purchase_list.new
      @on_hold_request=[]
  	end
    def set_price(breed)
      @@all_breed.each do |k,v|
        return v if k==breed
      end
    end
  	def generate_request
      @purchase_list.list.each do |k,v|
        @on_hold_request << {k=>v} if @puppy_list=={} && @on_hold_request==[] || !@on_hold_request.include?({k=>v}) 
          @puppy_list.each do |key,value|
            if value.include?(v) && (@purchase_request=={} || @purchase_request.values[-1][0]!=key )
              @purchase_request[k]=[key,v,value[1],value[2]]
            elsif @on_hold_request[-1]!={k=>v}
              @on_hold_request << {k=>v}
            end
          end
      end
      @puppy_list.each do |key,value|
        @on_hold_request.each do |pair|
          if value.include?(pair.values.join(""))
            @on_hold_request.delete(pair)
            break
          end
        end
      end
  	end
  	def accept_requests(customer)
  		if @puppy_list.keys.include?(@purchase_request[customer][0])
  		    @completed_request[customer]=@purchase_request[customer]
  		    @purchase_request.delete(customer)
  		    @puppy_list.delete(@completed_request[customer][0])
  		end
  	end
  	def input_request
  		customer=""
  		puppy=""
  		breed=""
      age=""
  		puts "Please input customer's name"
  		customer=gets.chomp
  		puts "Please input puppy's name"
  		puppy=gets.chomp
      puts "Please input puppy's breed"
      breed=gets.chomp
  		puts "Please input puppy's age"
  		age=gets.chomp.to_i
  		if @puppy_list.keys.include?(puppy)
  		    @purchase_request[customer]=[puppy,breed,age,self.set_price(breed)]
  		else
  			return nil
  		end
  	end
  	def add_puppy(puppy,breed,age)
  		@puppy=PuppyBreeder::Puppy.new(puppy,breed,age,self.set_price(breed))
  		@puppy_list[@puppy.name]=[@puppy.breed,@puppy.age,@puppy.price]
  	end
  end
end