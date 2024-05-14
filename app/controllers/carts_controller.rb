class CartsController < ApplicationController
  before_action :set_cart, only: [:show]

  def show
  end

  def destroy
    Cart.find(session[:cart_id])
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Cart was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
  
  def set_cart
    @cart = Cart.find(params[:id])
  end

end
