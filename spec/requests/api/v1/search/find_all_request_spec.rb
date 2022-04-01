require 'rails_helper'

describe "Find All/Search" do
  it 'Returns all items with matching description or name' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item List", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "Description List", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=list"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 18
  end

  it 'Returns all merchants with matching description or name' do
    Merchant.destroy_all
    Item.destroy_all
    merchants = create_list(:merchant, 10, name: 'Merchants')
    merchants2 = create_list(:merchant, 10, name: 'Distributors')

    get "/api/v1/merchants/find_all?name=dist"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 10
  end
end
