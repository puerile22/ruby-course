#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_reader :age,:name
  	def initialize(name,age)
  		@name=name
  		@age=age
  	end
  end
end