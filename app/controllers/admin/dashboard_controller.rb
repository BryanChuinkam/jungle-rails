class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USERNAME"], password: ENV["HTTP_BASIC_PASSWORD"]

  def show
    @num_products = Product.count
    @num_categories = Category.count
  end
end
