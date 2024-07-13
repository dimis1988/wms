class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    unless current_user 
      session[:redirect_to_new_order] = true
      redirect_to checkout_path
    else
      @order = current_user.orders.build
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @order = current_user.orders.build(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.user_id = current_user.id

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        customer = Stripe::Customer.create({
          :email => params[:stripeEmail],
          :source => params[:stripeToken]
        })
        
        charge = Stripe::Charge.create({
          :customer => customer.id,
          :amount => (@cart.total_price * 100).to_i,
          :description => 'Description of your product',
          :currency => 'eur'
        })
        format.html { redirect_to root_path, notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
    
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end
    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :total_price, :status)
    end
end
