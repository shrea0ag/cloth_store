class Search < ApplicationRecord
	validate :one_of_the_field_should_be_filled

	def one_of_the_field_should_be_filled
		if [keywords, gender, min_price, max_price].all? {|search| search.eql?(false)}
      errors.add("one field should be selected")
    end
	end

	def search_products
		products = Product.all

		products = products.where(["name LIKE ?","%#{keywords}%"]) if keywords.present?
		products = products.where(["gender LIKE ?", "#{gender}"]) 
		products = products.where(["price >= #{min_price}"]) if min_price.present?
		products = products.where(["price <= #{max_price}"]) if max_price.present?
		return products
	end
end
