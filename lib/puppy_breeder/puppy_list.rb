module PuppyBreeder
	class Puppy_list
		attr_accessor :list
		def initialize
			@list={}
		end
		def add(name,age)
			@list[name]=age
		end
		def remove(name)
			@list.delete(name)
		end
	end
end