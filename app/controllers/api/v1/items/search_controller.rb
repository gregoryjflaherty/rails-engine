class Api::V1::Items::SearchController < ApplicationController
  def index
    items = ItemFacade.search(params)
    filter_errors(items, ItemSerializer.new(items))
  end

  def show
    item = ItemFacade.search(params)
    filter_errors(item, ItemSerializer.new(item))
  end

  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end
end
