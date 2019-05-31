class OrderItemsController < ApplicationController
	before_action :authenticate_borrower!
	before_action :find_order_item, only:[:edit, :update]
	def create
	 	@order_item = current_borrower.order_items.build(order_item_params)
	 	@order_item.order = current_borrower.open_order
		if @order_item.save
			if params[:cart]
				flash[:success] = "Added"
				redirect_to borrower_path(current_borrower)
			else
				flash[:success] = "Order Placed"
				redirect_to edit_order_path(@order_item.order)
			end
		else
			flash[:error] = @order_item.errors.full_messages.to_sentence
			redirect_to products_path
		end
	end

	def edit
	end

	def update
		@order_item.update_attributes(order_item_params)
		if @order_item.save
			redirect_to borrower_path(current_borrower)
		else
			flash.now[:error] = @order_item.errors.full_messages.to_sentence
			render 'edit'
		end
	end

	def destroy
		@order_item = current_borrower.order_items.find_by(id: params[:id])
    @order_item.destroy
    redirect_to borrower_path(current_borrower)
	end

	private
	def order_item_params
		params.require(:order_item).permit(:quantity, :size, :color, :product_id, :total)
	end

	def find_order_item
    @order_item = OrderItem.find(params[:id])
  end
end
