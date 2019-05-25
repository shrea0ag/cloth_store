class ProductsController < ApplicationController
	# before_action :authenticate_borrowee!, on: [:create, :update]

  def index
     @products = Product.all
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = current_borrowee.products.build(product_params)
    if @product.save
     flash[:success] = "Product Added"
  	 redirect_to borrowees_path(@borrowee)
    else
      flash.now[:error] = @product.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_borrower.order_items.new
  end

  def edit
  end

  def destroy
    @product = current_borrowee.products.find_by(id: params[:id])
    @product.destroy
    redirect_to borrowees_path(@borrowee)
  end

  private
  def product_params
  	params.require(:product).permit(:name, :size_s, :size_xs, :size_m, :size_l, :size_xl, :color, :price)
  end
end
