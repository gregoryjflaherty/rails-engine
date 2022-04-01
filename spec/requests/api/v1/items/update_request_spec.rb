require 'rails_helper'

describe "Item Update API" do
  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "New Item Name" }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("New Item Name")
  end

  it "returns error if id is string" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "New Item Name" }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/itemone", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to_not be_successful
    expect(response.status).to eq 404
  end

  it "returns error if merchant id is bad" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "New Item Name", merchant_id: 9999999999 }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to_not be_successful
    expect(response.status).to eq 404
    expect(response.message).to eq "Not Found"
  end
end
