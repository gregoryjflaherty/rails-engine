require 'rails_helper'

describe "Item Index API" do
  it "can create a new item" do
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

    expect(response).to be_successful
    expect(new_item.name).to eq(item_params[:name])
    expect(new_item.description).to eq(item_params[:description])
    expect(new_item.unit_price).to eq(item_params[:unit_price])
    expect(new_item.merchant_id).to eq(item_params[:merchant_id])
  end
end
