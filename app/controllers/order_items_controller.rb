class OrderItemsController < ApplicationController

	

	def create
	 	@order_item = current_borrower.order_items.build(order_item_params)
		if @order_item.save
			flash[:success] = "Order Placed"
			redirect_to @order_item
		else
			flash.now[:error] = @order_item.errors.full_messages.to_sentence
			redirect_to products_path
		end
	end

	def show 
		@order_item = OrderItem.find(params[:id])
		@order      = current_borrower.orders.new
	end

	private
	def order_item_params
		params.require(:order_item).permit(:quantity, :size, :color, :days, :product_id)
	end
end
