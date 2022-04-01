require 'rails_helper'

describe "Find A Merchants Items" do
  it "retrieves all items belonging to a merchant" do
    merchant = Merchant.create!(name: "Fake Merchant")
    merchant2 = Merchant.create!(name: "Fake Merchant 2")


    item1 = merchant.items.create!(name: "Item 1")
    item2 = merchant.items.create!(name: "Item 2")
    item3 = merchant.items.create!(name: "Item 3")
    item4 = merchant.items.create!(name: "Item 4")
    item5 = merchant2.items.create!(name: "Item 5")
    item6 = merchant2.items.create!(name: "Item 6")

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items[:data].count).to eq(4)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
      expect(item[:attributes][:merchant_id]).to_not eq(merchant2.id)
    end
  end

  it "returns error if merchant is not found" do
    id = create(:merchant).id

    get "/api/v1/merchants/5000000"


    expect(response).to_not be_successful
    expect(response.status).to eq 404
    expect(response.message).to eq "Not Found"
  end
end
