class OrdersController < ApplicationController

	def index
		@order = Order.all
	end

 #  def create
	#  	@order = current_borrower.orders.build(order_params)
	# 	if @order.save
	# 		flash[:success] = "Order Placed"
	# 		redirect_to @order
	# 	else
	# 		flash.now[:error] = @order.errors.full_messages.to_sentence
	# 		redirect_to products_path
	# 	end
	# end

	def show 
		@order = Order.find(params[:id])
	end

	def edit
		@order = current_borrower.orders.find_by(id: params[:id])
	end

	def update
		@order = Order.find(params[:id])
		debugger
	  if @order.update_attributes(order_params)
	  	if params[:return]
	  		flash[:success] = "Order Returned"
	  		redirect_to new_checkout_path(order_id: @order.id)
	  	else
		  	flash[:success] = "Order Borrowed"
		    redirect_to borrowers_path
		  end
	  else
	  	flash.now[:error] = @order.errors.full_messages.to_sentence
	    render 'edit'
	  end
	end
	 

	private
	def order_params
		params.require(:order).permit(:actual_return_date, :status, :total, :address, :phone, :days)
	end
end
