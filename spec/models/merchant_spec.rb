require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items)}

  describe '#class_methods' do
    before(:each) do
      @merchant1 = Merchant.create(name: "Big Dog")
      @merchant2 = Merchant.create(name: "Little Dog")
      @merchant3 = Merchant.create(name: "BigLittle Dog")
    end

    context '#search_name' do
      it 'returns one merchant, that meets criteria' do
        result = Merchant.search_name("Big")

        expect(result).to be_an_instance_of(Merchant)
        expect(result).to eq(@merchant1)
      end
    end

    context '#search_all_names' do
      it 'returns all merchants, that meet criteria' do
        result = Merchant.search_all_names("Big")

        expect(result).to include(@merchant1)
        expect(result).to include(@merchant3)
        expect(result).to_not include(@merchant2)
      end

      it 'returns a list of only 18' do
        Merchant.destroy_all
        create_list(:merchant, 20, name: "Big Dogs")

        result = Merchant.search_all_names("Big")
        expect(result.length).to eq(18)
      end
    end
  end
end
