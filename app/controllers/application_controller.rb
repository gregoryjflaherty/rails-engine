class ApplicationController < ActionController::API
  include ActionController::Helpers

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_message

   def not_found_message(exception)
     render json: { status: "Not Found"}, status: 404
   end

   def invalid_message(exception)
     render json: exception.record.errors, status: :not_found
   end
end
