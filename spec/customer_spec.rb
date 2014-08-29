require_relative 'spec_helper.rb'

describe PuppyBreeder::Customer do
	describe "#initialize" do 
		it "create a customer instance" do
			customer=PuppyBreeder::Customer.new("Peng")
			expect(customer.name).to eq('Peng')
		end
	end
	describe "#make_request" do
		it "allows the customer to make a purchase request" do
			customer=PuppyBreeder::Customer.new("Peng")
			breeder=PuppyBreeder::Breeder.new('Jon')
			puppy=PuppyBreeder::Puppy.new('Leo',3)
			list=PuppyBreeder::Purchase_list.new
			customer.make_request(breeder,puppy,400)
			list.add(customer.request)
			expect(list.list).to eq({"Peng"=>['Jon','Leo',400]})
		end
	end

end