require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'relationships' do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe '.instance methods' do
    context '.get_invoices' do
        it 'gets invoices where this item is the only item on it' do
        merchant = Merchant.create!(name: "Fake Merchant")
        customer1 = Customer.create(first_name: "Greg", last_name: 'F')
        customer2 = Customer.create(first_name: "Katie", last_name: 'F')
        customer3 = Customer.create(first_name: "Laura", last_name: 'F')
        invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id )
        invoice2 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id )
        invoice3 = Invoice.create!(customer_id: customer3.id, merchant_id: merchant.id )
        item1 = Item.create!(name: 'Default Item 1',
                description: 'describes things about the item',
                unit_price: 10.5,
                merchant_id: merchant.id)
        item2 = Item.create!(name: 'Default Item 2',
                description: 'describes things about the item',
                unit_price: 10.5,
                merchant_id: merchant.id)
        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id)
        invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice3.id)
        invoice_item4 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id)


        expect(item1.get_invoices).to include(item1.id)
        expect(item1.get_invoices).to include(item2.id)
      end
    end
  end

  describe '#class_methods' do
    before(:each) do
      @merchant = Merchant.create!(name: "Fake Merchant")

      @item1 = @merchant.items.create!(name:"Cherry Lime", unit_price: 10.0)
      @item2 = @merchant.items.create!(name:"Sour Cheese", unit_price: 15.0)
      @item3 = @merchant.items.create!(name:"Double Dutch Bus", unit_price: 20.0)
    end

    context '#search_name' do
      it 'returns one item based on search' do
        result = Item.search_name('Che')

        expect(result).to eq(@item1)
      end
    end

    context '#search_all_names' do
      it 'returns all items based on search' do
        result = Item.search_all_names('Che')

        expect(result).to include(@item1)
        expect(result).to include(@item2)
        expect(result).to_not include(@item3)
      end

      it 'returns a list of only 18' do
        Item.destroy_all
        create_list(:item, 20, name: "Cherry Lime")

        result = Item.search_all_names("Cherry")
        expect(result.length).to eq(18)
      end
    end

    context '#search_by_min_price' do
      it 'returns first item unit_price higher than or equal to search' do
        result = Item.search_by_min_price('14.99')

        expect(result).to eq(@item3)
      end
    end

    context '#search_by_max_price' do
      it 'returns first item unit_price lower than or equal to search' do
        result = Item.search_by_max_price('19.99')

        expect(result).to eq(@item1)
      end
    end

    context '#between_range' do
      it 'returns first item unit_price lower than or equal to search' do
        result = Item.between_range('10.99', '15.99')

        expect(result).to eq(@item2)
      end
    end
  end
end
