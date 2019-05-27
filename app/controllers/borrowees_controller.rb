class BorroweesController < ApplicationController
	before_action :authenticate_borrowee!

  def show
  	@borrowee = Borrowee.find(params[:id])
  end

  
end
