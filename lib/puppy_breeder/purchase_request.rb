#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_accessor :customer,:puppy,:price,:breeder
  	def initialize(customer,puppy,price,breeder)
  		@customer,@puppy, @price, @breeder =customer, puppy, price, breeder
  	end
  end
end