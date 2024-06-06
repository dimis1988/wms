class Admin::AdminController < ApplicationController
  before_action :authorize_admin

  def index
    @last_five_paid_orders = Order.where(status: 'paid').order('created_at DESC').limit(5)
    @most_sold_products = 
    Product.joins(:line_items)
    .select('products.*, SUM(line_items.quantity) as total_quantity')
    .group('products.id')
    .order('total_quantity DESC')

    @stats = {
      paid_orders: Order.where(status: 'paid').count,
      new_users: User.where('created_at > ?', 1.months.ago).where(admin: false).count,
      total_profit: Order.where(status: 'paid').sum(:total_price),
       top_selling_product: 
           LineItem.joins(:product)
           .group("products.name")
           .sum(:quantity)
           .sort_by { |product, quantity| -quantity }.map(&:first)
  }
  end


  private

  def authorize_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
  
end