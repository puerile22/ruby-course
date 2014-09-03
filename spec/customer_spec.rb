require_relative 'spec_helper.rb'

describe PuppyBreeder::Customer do
	let(:customer) {PuppyBreeder::Customer.new("Peng")}
	let(:breeder) {PuppyBreeder::Breeder.new('Jon')}
	let(:list) {PuppyBreeder::Purchase_list.new}
	describe "#initialize" do
		it "create a customer instance" do
			expect(customer.name).to eq('Peng')
		end
	end
	describe "#make_request" do
		it "allows the customer to make a purchase request" do
			breeder.add_puppy('Leo','Alaskan',200)
			breed=breeder.puppy_list['Leo'][0]
			customer.make_request(breed)
			list.add(customer.request)
			expect(list.list).to eq({"Peng"=>"Alaskan"})
		end
	end

end