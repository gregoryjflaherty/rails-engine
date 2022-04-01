class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = MerchantFacade.search(params)
    filter_errors(merchants, MerchantSerializer.new(merchants))
  end

  def show
    merchant = MerchantFacade.search(params)
    filter_errors(merchant, MerchantSerializer.new(merchant))
  end

  private

  def search_params
    params.permit(:name)
  end
end
