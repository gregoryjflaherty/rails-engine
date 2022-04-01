class Api::V1::ItemMerchantsController < ApplicationController
  before_action :find_item, only: [:show]
  before_action :find_merchant, only: [:index, :show]

  def index
    render json: ItemSerializer.new(@merchant.items)
  end

  def show
    render json: MerchantSerializer.new(@merchant)
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def find_merchant
    if params[:action] == 'index'
      @merchant = Merchant.find(params[:merchant_id])
    else
      @merchant = Merchant.find(@item.merchant_id)
    end
  end
end
