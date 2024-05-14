class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    protected 

    def after_sign_in_path_for(resource)
        if session[:redirect_to_new_order]
          session.delete(:redirect_to_new_order)
          new_order_path
        else
          stored_location_for(resource) || root_path
        end
    end

    def after_sign_up_path_for(resource)
        if session[:redirect_to_new_order]
          session.delete(:redirect_to_new_order)
          new_order_path
        else
          stored_location_for(resource) || root_path
        end
      end

    def record_not_found
        flash[:alert] = "Product not found"
        redirect_to root_path
    end
end
