class ItemFacade
  def self.search(params)
    if params[:name]
      if params[:action] == "show"
        Item.search_name(params[:name])
      else
        Item.search_all_names(params[:name])
      end
    elsif params[:min_price] && params[:max_price]
      Item.between_range(params[:min_price], params[:max_price])
    elsif params[:min_price]
      Item.search_by_min_price(params[:min_price])
    elsif params[:max_price]
      Item.search_by_max_price(params[:max_price])
    end
  end

  def self.destroy_invoices(ids)
    ids.each {|id| Invoice.find(id).destroy!}
  end
end
