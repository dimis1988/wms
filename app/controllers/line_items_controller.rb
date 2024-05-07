class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show]

  def index
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity]
    @line_item = @cart.add_to_cart(product, quantity)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: "Product was successfully added to cart." }
        format.json { render :show }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end



  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_items_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
