module PuppyBreeder
	class Purchase_list
		attr_accessor :list,:completed_list
		def initialize
			@list={}
			@completed_list={}
		end
		def add(request)
			@list[request.customer]=[request.breeder,request.puppy,request.price]
		end
		def remove(customer)
			@completed_list[customer]=@list[customer]
			@list.delete(customer)
		end
	end
end