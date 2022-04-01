class MerchantFacade
  def self.search(params)
    if params[:name]
      if params[:action] == "show"
        Merchant.search_name(params[:name])
      else
        Merchant.search_all_names(params[:name]) if params[:action] == "index"
      end
    end
  end
end
