class PagesController < ApplicationController
  def home
    @products = Product.order(created_at: :desc).limit(3).includes(:product_category)
  end

  def about
  end
end
