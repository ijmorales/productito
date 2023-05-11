class ProductsController < BaseController
  def index
    respond Product.all
  end

  def show
    respond 'Products show'
  end

  def create
    # TODO: Make this async
    Product.new(request.params).save
    respond 'Product creation scheduled'
  end
end
