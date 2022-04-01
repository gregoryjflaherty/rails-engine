require 'rails_helper'

describe "Item Delete API" do
  it "can create a new item and delete it" do
    merchant = Merchant.create!(name: "Fake Merchant")

    item_params = ({
                    name: 'Default Item',
                    description: 'describes things about the item',
                    unit_price: 10.5,
                    merchant_id: merchant.id,
                  })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    new_item = Item.last

    delete "/api/v1/items/#{new_item.id}"
    expect(response).to be_successful
    expect{Item.find(new_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(response.status).to eq(204)
  end

  it 'deletes invoices if only item on invoice' do
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

    delete "/api/v1/items/#{item1.id}"
    expect(response).to be_successful
    expect(Invoice.all).to include(invoice3)
    expect(Invoice.all).to_not include(invoice1)
    expect(Invoice.all).to_not include(invoice2)
  end

  context 'sad path' do
    it 'returns error if bad ID given' do
      delete "/api/v1/items/0"

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end

    it 'returns error if string given' do
      delete "/api/v1/items/best_item"

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end
end
