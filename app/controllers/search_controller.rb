class SearchController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:product_category).paginate(page: params[:page], per_page: 6)
  end
end
