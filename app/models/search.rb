class Search < ApplicationRecord
	def search_products
		products = Product.all

		products = products.where(["name LIKE ?","%#{keywords}%"]) if keywords.present?
		products = products.where(["gender LIKE ?", "#{gender}"]) 
		# products = products.where(:size_xs => true) if size_xs.present?
		products = products.where(["price >= #{min_price}"]) if min_price.present?
		products = products.where(["price <= #{max_price}"]) if max_price.present?
		# products = products.where(:size_l => true) 
		return products
	end
end
