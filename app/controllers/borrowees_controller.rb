class BorroweesController < ApplicationController

	def index
  	@borrowees = Borrowee.all
  end
  
end
