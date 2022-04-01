require 'rails_helper'

describe "Find/Search" do
  it 'Returns one item with matching description or name' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item List", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "Description List", merchant_id: merchant.id)

    get "/api/v1/items/find?name=list"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected.length).to eq(1)
    expect(expected[:data][:attributes][:name]).to eq("Item List")
    expect(expected[:data].length).to eq 3
  end

  it 'Returns one merchant with matching description or name' do
    Merchant.destroy_all
    Item.destroy_all
    merchant1 = create(:merchant, name: 'Biggie Dog')
    merchant2 = create(:merchant, name: 'Little Dog')

    get "/api/v1/merchants/find?name=igg"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected.length).to eq 1
    expect(expected[:data][:attributes][:name]).to eq("Biggie Dog")
    expect(expected[:data].length).to eq 3
  end

  it 'Returns one item with a min_price' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)

    get "/api/v1/items/find?min_price=4.99"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 3
  end

  it 'Returns items with a max_price' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)

    get "/api/v1/items/find?max_price=10.00"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 3
  end

  it 'Returns items with both a min & maxprice' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 30.00, merchant_id: merchant.id)

    get "/api/v1/items/find?min_price=2.50&max_price=22.00"

    expected = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 3
  end

  it 'Returns status if no matches found' do
    Item.destroy_all
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, name: "Little Dog Food", merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, name: "Big Dog Food", merchant_id: merchant.id)


    get "/api/v1/items/find?name=cat"

    expected = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:message]).to eq("No matches for search input")
  end

  it 'Should error out if name and max price are sent' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item List", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "List of descriptions", merchant_id: merchant.id)

    get "/api/v1/items/find?name=list&max_price=10.00"

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end

  it 'Should error out if name and min price are sent' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item List", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "List of descriptions", merchant_id: merchant.id)

    get "/api/v1/items/find?name=list&min_price=2.00"

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end

  it 'Should error out if given id is wrong' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item list", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "List of descriptions", merchant_id: merchant.id)

    get "/api/v1/items/find?id= "


    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end

  it 'Should error out if min price is greater than max price' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item list", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "List of descriptions", merchant_id: merchant.id)

    get "/api/v1/items/find?min_price=5.00&max_price=2.00"


    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end

  it 'Should error out if both name and price min/max are sent' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "Item list", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "List of descriptions", merchant_id: merchant.id)

    get "/api/v1/items/find?name=list&min_price=3.50&max_price=10.00"

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end

  it "Should error out if parameter is missing or empty" do
    get "/api/v1/items/find"

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')

    get "/api/v1/items/find?name="

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')

    get "/api/v1/items/find?min_price="

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end

  it "Should error out if parameter is negative number" do
    get "/api/v1/items/find?min_price=-1"

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(response.message).to eq('Bad Request')
  end
end
