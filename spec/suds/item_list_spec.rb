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
    let(:item_file) { YAML.load_file('spec/fixtures/test_items.yml') }

    describe "::create" do
      subject { ItemList.create(item_file) }

      it "returns an hash of Item objects with names as keys" do
        expect(subject.class).to eq Hash
        subject.each { |name, item| expect(name).to eq item.name  }
      end
    end
  end
end