class OrdersController < ApplicationController
	before_action :authenticate_borrower!
	before_action :find_order, only:[:show, :update]

	def index
		@order = Order.all
	end

	def show 
	end

	def edit
		@order = current_borrower.orders.find_by(id: params[:id])
	end

	def update
	  if @order.update_attributes(order_params)
	  	if params[:return]
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

	def find_order
		@order = Order.find(params[:id])
	end
end
