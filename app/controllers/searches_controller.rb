class SearchesController < ApplicationController
	before_action :authenticate_borrower!
	def new
		@search = Search.new
	end

	def create
		@search = Search.create(search_params)
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])
	end

	private
	def search_params
		params.require(:search).permit(:keywords, :max_price, :min_price, :gender)
	end
end
