#Refer to this class as PuppyBreeder::Customer
module PuppyBreeder
  class Customer
  	attr_accessor :request
  	attr_reader :name
  	def initialize(name)
  		@name=name
  	end
  	def make_request(breed)
  		@request=PuppyBreeder::PurchaseRequest.new(self.name,breed)
  	end
  end
end