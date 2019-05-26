class OrdersController < ApplicationController

	def index
		@order = Order.all
	end

  def create
	 	@order = current_borrower.orders.build(order_params)
		if @order.save
			flash[:success] = "Order Placed"
			redirect_to borrowers_path(@borrower)
		else
			flash.now[:error] = @order.errors.full_messages.to_sentence
			redirect_to products_path
		end
	end

	def show 
		@order = Order.find(params[:id])
	end

	def edit
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
	  if @order.update(order_params)
	  	flash[:success] = "Order Returned"
	    redirect_to @order
	  else
	  	flash.now[:error] = @order.errors.full_messages.to_sentence
	    render 'edit'
	  end
	end
	 

	private
	def order_params
		params.require(:order).permit(:order_item_id, :actual_return_date, :status, :total, :address, :phone)
	end
end
