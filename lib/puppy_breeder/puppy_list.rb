module PuppyBreeder
	class Puppy_list
		attr_accessor :list
		def initialize
			@list={}
		end
		def add(puppy)
			@list[puppy.name]=[puppy.breed,puppy.age,puppy.price]
		end
		def remove(puppy)
			@list.delete(puppy)
		end
	end
end