#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_reader :age,:name,:breed,:price
  	def initialize(name,breed,age,price)
  		@name=name
  		@breed=breed
  		@age=age
  		@price=price
  	end
  end
end