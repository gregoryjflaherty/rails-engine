require 'rails_helper'

describe "Find An Items Merchant" do
  it "retrieves all items belonging to a merchant" do
    merchant = Merchant.create!(name: "Fake Merchant")
    merchant2 = Merchant.create!(name: "Fake Merchant 2")


    item1 = merchant2.items.create!(name: "Item 1")

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant[:data].count).to eq(3)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(merchant2.id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq(merchant2.name)
  end


    it "returns error if item is not found" do
      id = create(:merchant).id

      get "/api/v1/items/5000000"


      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(response.message).to eq "Not Found"
    end
end
