#Refer to this class as PuppyBreeder::Customer
module PuppyBreeder
  class Customer
  	attr_accessor :request
  	attr_reader :name
  	def initialize(name)
  		@name=name
  	end
  	def make_request(breeder,puppy,price)
  		@request=PuppyBreeder::PurchaseRequest.new(self.name,puppy.name,price,breeder.name)
  	end
  end
end