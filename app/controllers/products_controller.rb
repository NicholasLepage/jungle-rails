class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.includes(reviews: :user).find params[:id]
    @review = @product.reviews.new
    @reviews = @product.reviews.order(created_at: :desc)
  end

end
