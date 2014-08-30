require_relative "lib/puppy_breeder.rb"
#require "pry-byebug"

class TerminalClient
	@@purchase_list=PuppyBreeder::Purchase_list.new
	@@puppy_list=PuppyBreeder::Puppy_list.new
	@@breeder_list={}
	def initialize
		@request=""
		@breeder=""
		@new_customer=""
	end
	def start
		puts ""
		puts "Welcome to Puppy Breeder! What can I do for you today?"
		puts ""
		puts "Available Commands:"
		puts "help - Show these commands again"
		puts "create customer Name -- Create a new customer with name=Name, and making purchase command"
		puts "create breeder Name or access to breeder Name -- Create a new breeder with name=Name or access a instance of Breeder class with name=Name"
		puts "exit -- Exit the application"
		get_command
	end

	def get_command
		puts""
		print "> "
		input=gets.chomp

		split_input=input.split(" ")
		case split_input[0]
		when "help"
			self.start
		when "create"
			case split_input[1]
			when "customer"
				self.create_customer(split_input[2])
			when "breeder"
				self.create_breeder(split_input[2])
			else
				puts "Sorry, '#{split_input[1]}' is not a valid command. Use 'help' if you get stuck."
				self.get_command
			end
		when "exit"
			exit
		else
			puts "Sorry, '#{split_input[0]}' is not a valid command. Use 'help' if you get stuck."
			self.get_command
		end
	end

	def create_customer(name)
		@new_customer=PuppyBreeder::Customer.new(name)
		puts "Dear #{name}, here's the list of all the available puppies."
		puts @@puppy_list.list
		puts ""
		puts 'You can make your purchase request based on a breed now.'
		breed=gets.chomp
		if @@puppy_list.list.values.join(" ").include?(breed)
            @request = PuppyBreeder::PurchaseRequest.new(name,breed)
		    @@purchase_list.list[@request.customer]=@request.breed
		    puts "Successfully add a new purchase request!"
	    else
		    puts "Sorry, we don't have this breed you are looking for right now."
	    end
	    self.start		
	end
	def create_breeder(name)
		if @@breeder_list.keys.include?(name)
			puts "#{name}, welcome back!"
			@breeder=@@breeder_list[name]
		else
			@@breeder_list[name]=PuppyBreeder::Breeder.new(name)
			@breeder=@@breeder_list[name]
			puts "Successfully created a new breeder!"
		end
		start_breeder
	end

	def start_breeder
		puts ""
		puts ""
		puts "Welcome to Breeder Manager! What can I do for you today?"
		puts ""
		puts "Available commands:"
		puts "help -- Show these commands again."
		puts "add puppy -- add new puppies for sale."
		puts "review purchase request and accept -- review purchase requests and accept new purchase requests."
		puts "view -- view all the completed requests."
		puts "exit breeder -- Exit the Breeder Manager."
		get_breeder_command
	end
	def get_breeder_command
		puts ""
		puts "> "
		input=gets.chomp
		split_input=input.split(" ")
		case split_input[0]
		when "help"
			self.start_breeder
		when "add"
			puts "Please input the puppy's name:"
			name=gets.chomp
			puts "Please input the puppy's breed:"
			breed=gets.chomp
			puts "Please input the puppy's age:"
			age=gets.chomp.to_i
			@breeder.add_puppy(name,breed,age)
			@@puppy_list.add(@breeder.puppy)
			puts "Puppy added successfully!"
			self.start_breeder
		when "review"
			@breeder.purchase_list=@@purchase_list
			@breeder.generate_request
			puts "Here's the purchase list:"
			puts @breeder.purchase_request
			puts "Please choose the request you want to accept by the customer's name:"
			customer=gets.chomp
			@breeder.accept_requests(customer)
			@@purchase_list.remove(customer)
			@@puppy_list.remove(@breeder.completed_request[customer][0])
			puts "Successfully sold #{@breeder.completed_request[customer][0]} to #{customer}!"
			self.start_breeder
		when "view"
			puts "Here's the completed request list:"
			puts @breeder.completed_request
			self.start_breeder
		when "exit"
			self.start
		else
			puts "Sorry, '#{split_input[0]}' is not a valid command. Use 'help' if you get stuck."
			self.get_breeder_command
		end
	end
end

TerminalClient.new.start



