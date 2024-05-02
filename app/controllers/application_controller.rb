class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private 

    def record_not_found
        flash[:alert] = "Product not found"
        redirect_to root_path
    end
end
