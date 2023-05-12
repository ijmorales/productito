class ProductsController < BaseController
  def index
    respond Product.all
  end

  def show
    # TODO: Implement product show
    respond 'Products show'
  end

  def create
    Product.create_async(params, wait: 5)
    respond 'Product creation scheduled'
  end
end
