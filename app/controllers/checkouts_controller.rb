class CheckoutsController < ApplicationController
  
  def new 
    @client_token = CheckoutsService.gateway.client_token.generate
    @order = Order.find(params[:order_id])
  end

  def show
    @transaction = CheckoutsService.gateway.transaction.find(params[:id])
    @result = CheckoutsService._create_result_hash(@transaction)
  end

  def create
    amount = params["amount"] # In production you should not take amounts directly from clients
    nonce = params["payment_method_nonce"]
    
    result = CheckoutsService.transaction_sale(amount,nonce)

    if result.success? || result.transaction
      order = Order.find(params[:order_id])
      order.create_payment(order_id: order.id,amount: amount, token: nonce, transaction_id: result.transaction.id)
      order.update_attributes(status: "returned",actual_return_date: Date.today, total: amount)
      redirect_to checkout_path(result.transaction.id) 
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:danger] = error_messages
      redirect_to new_checkout_path(order_id: params[:order_id])
    end
  end
end
