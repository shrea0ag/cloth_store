class BorrowersController < ApplicationController
	before_action :authenticate_borrower! 
	def index
		@borrowers = Borrower.all
	end

	def show
  	@borrower = Borrower.find(params[:id])
  end
end
