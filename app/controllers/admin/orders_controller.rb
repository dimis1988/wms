class Admin::OrdersController < Admin::AdminController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result.order('created_at DESC').paginate(page: params[:page], per_page: 10).includes(:user)
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

  def destroy
    @order = Order.find(params[:id])
    @line_items = LineItem.find(params[:id])
    @order.destroy!
    redirect_to admin_orders_path, notice: "Order was successfully deleted."
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

end
