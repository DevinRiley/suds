require 'spec_helper'

module SUDS
	describe Item do
		subject { Item.new('a', 'b','c', 'd') }
		describe "has all the expected properties" do
			it { expect(subject.respond_to? :name).to eq true }
			it { expect(subject.respond_to? :category).to eq true }
			it { expect(subject.respond_to? :type).to eq true }
			it { expect(subject.respond_to? :description).to eq true }
		end
	end

	describe ItemList do
		let(:input_list) { YAML.load_file('spec/fixtures/test_items.yml')['items'] }
		subject { ItemList.create(input_list) }

		it "returns an array of Item objects" do
			expect(subject.class).to eq Array
			subject.each { |item| expect(item.class).to eq Item  }
		end
	end
end