class BorrowersController < ApplicationController

	def index
		@borrowers = Borrower.all
	end
end
