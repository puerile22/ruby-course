require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	describe "#initialize" do
		it "create a breeder instance" do
			breeder=PuppyBreeder::Breeder.new("Jon")
			expect(breeder.name).to eq('Jon')
		end
	end
	describe "#add_puppy" do
		it "allows breeder to add new puppies to sell" do
			breeder=PuppyBreeder::Breeder.new("Jon")
			breeder.add_puppy("Leo",2)
			expect(breeder.puppy_list).to eq({"Leo"=>2})
		end
	end
	describe "#input_request" do
		it "allows breeder to manually input a purchase request" do
			breeder=PuppyBreeder::Breeder.new("Jon")
			breeder.add_puppy('Leo',2)
			breeder.input_request
			expect(breeder.purchase_request).to eq({"Peng"=>["Leo",2]})
		end
		it "will return nil if the breeder doesn't have this puppy" do
			breeder=PuppyBreeder::Breeder.new("Jon")
			expect(breeder.input_request).to be_nil
		end
	end
	describe "#accept_request" do
		it "allows breeder to accept purchase request" do
			breeder=PuppyBreeder::Breeder.new("Jon")
			breeder.add_puppy('Leo',2)
			customer=PuppyBreeder::Customer.new("Peng")
			puppy_list=PuppyBreeder::Puppy_list.new
			puppy=breeder.puppy
			puppy_list.add(puppy.name,puppy.age)
			customer.make_request(breeder,puppy,400)
			breeder.purchase_list.add(customer.request)
			expect(puppy_list.list).to eq({'Leo'=>2})
			breeder.generate_request
			expect(breeder.purchase_request).to eq({"Peng"=>["Leo",2]})
			breeder.accept_requests(customer)
			expect(breeder.purchase_request).to eq({})
			expect(breeder.completed_request).to eq({"Peng"=>["Leo",2]})
			expect(breeder.puppy_list).to eq({})
		end
	end
end