class Admin::OrdersController < Admin::AdminController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update_status
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to admin_order_path(@order), notice: "Status was successfully updated."
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
