require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let (:breeder) {PuppyBreeder::Breeder.new("Jon")}
	let(:customer) {PuppyBreeder::Customer.new("Peng")}
	let(:puppy_list) {PuppyBreeder::Puppy_list.new}
	describe "#initialize" do
		it "create a breeder instance" do
			expect(breeder.name).to eq('Jon')
		end
	end
	describe "#add_puppy" do
		it "allows breeder to add new puppies to sell" do
			breeder=PuppyBreeder::Breeder.new("Jon")
			breeder.add_puppy("Leo",'Alaskan',200)
			expect(breeder.puppy_list).to eq({"Leo"=>['Alaskan',200,700]})
		end
	end
	describe "#input_request" do
		it "allows breeder to manually input a purchase request" do
			breeder.add_puppy('Leo','Alaskan',200)
			breeder.input_request
			expect(breeder.purchase_request).to eq({"Peng"=>['Leo','Alaskan',200,700]})
		end
		it "will return nil if the breeder doesn't have this puppy" do
			expect(breeder.input_request).to be_nil
		end
	end
	describe "#accept_request" do
		it "allows breeder to accept purchase request" do
			breeder.add_puppy('Leo','Alaskan',200)
			puppy=breeder.puppy
			puppy_list.add(puppy)
			customer.make_request('Alaskan')
			breeder.purchase_list.add(customer.request)
			expect(puppy_list.list).to eq({'Leo'=>['Alaskan',200,700]})
			breeder.generate_request
			expect(breeder.purchase_request).to eq({"Peng"=>['Leo','Alaskan',200,700]})
			breeder.accept_requests(customer.name)
			expect(breeder.purchase_request).to eq({})
			expect(breeder.completed_request).to eq({"Peng"=>['Leo','Alaskan',200,700]})
			expect(breeder.puppy_list).to eq({})
		end
	end
	describe "#generate_request" do
		it "put a purchase request on hold if there's no puppy suitable for the customer, and the breeder won't see the requests on hold. 
If a new puppy is available, the customer who made the request first gets the puppy first" do
			breeder.add_puppy('Leo','Alaskan',200)
			puppy=breeder.puppy
			puppy_list.add(puppy)
			customer.make_request('Hound')
			breeder.purchase_list.add(customer.request)
			expect(puppy_list.list).to eq({'Leo'=>['Alaskan',200,700]})
			breeder.generate_request
			expect(breeder.purchase_request).to eq({})
			expect(breeder.on_hold_request).to eq([{'Peng'=>'Hound'}])
			breeder.add_puppy('Yuki','Hound',300)
			breeder.generate_request
			expect(breeder.purchase_request).to eq({'Peng'=>['Yuki','Hound',300,1000]})
			expect(breeder.on_hold_request).to eq([])
			breeder.accept_requests(customer.name)
			expect(breeder.purchase_request).to eq({})
			expect(breeder.completed_request).to eq({"Peng"=>['Yuki','Hound',300,1000]})
			expect(breeder.puppy_list).to eq({'Leo'=>['Alaskan',200,700]})
		end
	end
end