#Refer to this class as PuppyBreeder::Breeder
module PuppyBreeder
  class Breeder
  	attr_reader :name
  	attr_accessor :puppy_list,:puppy,:purchase_request,:completed_request,:purchase_list
  	def initialize(name)
  		@name=name
  		@puppy_list={}
  		@purchase_request={}
  		@completed_request={}
      @purchase_list = PuppyBreeder::Purchase_list.new
  	end
  	def generate_request
  		@purchase_list.list.each do |k,v|
  			if v[0]==@name
  				@purchase_request[k]=[v[1],@puppy_list[v[1]]] 
  			end
  		end
  	end
  	def accept_requests(customer)
  		if @puppy_list.keys.include?(@purchase_request[customer.name][0])
  		    @completed_request[customer.name]=@purchase_request[customer.name]
  		    @purchase_request.delete(customer.name)
  		    @puppy_list.delete(@completed_request[customer.name][0])
  		end
  	end
  	def input_request
  		customer=""
  		puppy=""
  		price=""
  		puts "Please input customer's name"
  		customer=gets.chomp
  		puts "Please input puppy's name"
  		puppy=gets.chomp
  		puts "Please input puppy's age"
  		price=gets.chomp.to_i
  		if @puppy_list[puppy]==price
  		    @purchase_request[customer]=[puppy,price]
  		else
  			return nil
  		end
  	end
  	def add_puppy(puppy,age)
  		@puppy=PuppyBreeder::Puppy.new(puppy,age)
  		@puppy_list[@puppy.name]=@puppy.age
  	end
  end
end