class OrdersController < ApplicationController

	def create
	 	@order = current_borrower.orders.build(order_params)
		if @order.save!
			flash[:success] = "Order Processing"
			redirect_to @order
		else
			flash.now[:error] = @order.errors.full_messages.to_sentence
			redirect_to products_path
		end
	end

	def edit
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		debugger
	  if @order.update(order_params)
	  	flash[:success] = "Order Processing"
	    redirect_to @order
	  else
	  	flash.now[:error] = @order.errors.full_messages.to_sentence
	    render 'edit'
	  end
	end

	def order_params
		params.require(:order).permit(:status, :address, :phone, :email, :total, :order_item_id, :actual_return_date)
	end
end
