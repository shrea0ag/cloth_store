class OrdersController < ApplicationController
	before_action :authenticate_borrower!
	before_action :find_order, only:[:show, :update, :edit]

	def index
		@orders = current_borrower.orders.closed_orders
	end

	def show 
	end

	def edit
	end

	def update
	  if @order.update_attributes(order_params)
			flash[:success] = "Order Borrowed"
	    redirect_to borrowers_path
	  else
	  	flash.now[:danger] = @order.errors.full_messages.to_sentence
	    render 'edit'
	  end
	end
	 

	private
	def order_params
		params.require(:order).permit(:actual_return_date, :status, :total, :address, :phone, :days, :city, :pincode, :name)
	end

	def find_order
		@order = current_borrower.orders.find_by(id: params[:id])
	end
end
