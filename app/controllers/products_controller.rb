class ProductsController < ApplicationController
	before_action :authenticate_borrowee!, only: [:create, :update, :destroy]

  def index
    if @products = Product.where(["name LIKE ?","%#{params[:search]}%"])
    else
      @products = Product.all
    end
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = current_borrowee.products.build(product_params)
    if @product.save
     flash[:success] = "Product Added"
  	 redirect_to borrowee_path(current_borrowee)
    else
      flash.now[:error] = @product.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_borrower.order_items.new
  end

  # def edit
  #  @product = Product.find(params[:id])
  # end

  # def update
  #   @product = Product.find(params[:id])
  #   @product = current_borrowee.products.update_attributes(product_params)
  #   if @product.save
  #     flash[:success] = "Product Updated"
  #     redirect_to  borrowee_path(current_borrowee)
  #   else
  #     flash.now[:error] = @product.errors.full_messages.to_sentence
  #     render 'edit'
  #   end
  # end

  def destroy
    @product = current_borrowee.products.find_by(id: params[:id])
    @product.destroy
    redirect_to borrowee_path(current_borrowee)
  end

  private
  def product_params
  	params.require(:product).permit(:name, :size_s, :size_xs, :size_m, :size_l, :size_xl, :color, :count, :gender, :price, :image)
  end
end
