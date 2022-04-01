class ApplicationController < ActionController::API
  include ActionController::Helpers

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  rescue_from ActiveRecord::RecordInvalid, with: :not_found_message

   def not_found_message(exception)
     render json: { error: "Not Found"}, status: 404
   end

   def bad_request_error(message)
     render json: { error: 'BAD REQUEST', message: message, data: {} }, status: 400
   end

   def no_matches
     render json: { status: 'SUCCESS', message: 'No matches for search input', data: {} }, status: 200
   end

   def filter_errors(obj, result)
    if search_params[:min_price].to_i < 0 || search_params[:max_price].to_i < 0
      bad_request_error('Search criteria cannot be less than zero')
    elsif search_params[:min_price] == '' || search_params[:max_price] == ''
      bad_request_error('Incorrect or Incomplete Parameters')
    elsif (search_params[:min_price].nil? && search_params[:max_price].nil?)  && (search_params[:name].nil? || search_params[:name] == '')
      bad_request_error('Incorrect or Incomplete Parameters')
    elsif (!search_params[:min_price].nil? || !search_params[:max_price].nil?) && !search_params[:name].nil?
      bad_request_error('Name and Price Cannot Be Searched Together')
    elsif !search_params[:min_price].nil? && !search_params[:max_price].nil?
      if  search_params[:min_price].to_f > search_params[:max_price].to_f
        bad_request_error('Min price cannot be greater than max price')
      else
        render json: result
      end
    elsif obj.nil?
      no_matches
    else
      render json: result
    end
  end
end
