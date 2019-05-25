class PagesController < ApplicationController
 before_action :user_authentication
  
  def index
  end

  private
  def user_authentication
  	if borrowee_signed_in?
  	 redirect_to new_product_path
  	
    elsif borrower_signed_in?
  	 redirect_to products_path
  	else
  	 	render 'pages/index'
  	end
  end
end
