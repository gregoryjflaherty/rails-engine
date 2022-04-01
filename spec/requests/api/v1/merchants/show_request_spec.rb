require 'rails_helper'

describe "Merchant Show API" do
  it "can get one book by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "returns error if merchant is not found" do
    id = create(:merchant).id

    get "/api/v1/merchants/5000000"


    expect(response).to_not be_successful
    expect(response.status).to eq 404
    expect(response.message).to eq "Not Found"
  end
end
