class Admin::OrdersController < Admin::AdminController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

end
