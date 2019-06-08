class ProductsController < ApplicationController
	before_action :authenticate_borrowee!, only: [:create, :update, :destroy, :new, :edit]
  before_action :authenticate_borrower!, only:[:show, :index]
  before_action :find_product, only:[:edit, :update]
  

  def index
    @products = Product.paginate(page: params[:page], per_page: 3)
    if params[:search].present?
     @products = @products.where(["name LIKE ?","%#{params[:search]}%"]) 
    end
    
    if params[:searchmin].present?
      @products = @products.where(["price >= #{params[:searchmin]}"]) 
    end

    if params[:searchmax].present?
      @products = @products.where(["price <= #{params[:searchmax]}"]) 
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
      flash.now[:danger] = @product.errors.full_messages.to_sentence
      render 'new'  
    end
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_borrower.order_items.new
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      flash[:success] = "Product Updated"
      redirect_to  borrowee_path(current_borrowee)
    else
      flash.now[:danger] = @product.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @product = current_borrowee.products.find_by(id: params[:id])
    @product.destroy
    redirect_to borrowee_path(current_borrowee)
  end

  private
  def product_params
  	params.require(:product).permit(:name, :size_s, :size_xs, :size_m, :size_l, :size_xl, :color, :quantity, :gender, :price, :image)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
