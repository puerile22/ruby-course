#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_accessor :customer,:breed
  	def initialize(customer,breed)
  		@customer, @breed =customer, breed
  	end
  end
end