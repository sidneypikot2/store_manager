# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create({email: "test@gmail.com", password: "password", name: "Test User"})

products = [{sku: "ipd", name: "Super iPad", stock_count: 1000, price: 549.99}, {sku: "mbp", name: "MacBook Pro", stock_count: 1000, price: 1399.99},
            {sku: "atv", name: "Apple TV", stock_count: 1000, price: 109.50}, {sku: "vga", name: "VGA adapter", stock_count: 1000, price: 30.00}]

products.each do |product|
  Product.create(product)
end
# Scenario 1
product = Product.where(sku: "atv").first
product.promotion_attributes = {name: "3-for-2 Deal", status: 'active', buy_x_take_y_attributes: {buy_x_condition: 2, product_id: product.id}}
product.save

# Scenario 2
product = Product.where(sku: "ipd").first
product.promotion_attributes = {name: "Bulk Discount", status: 'active', buy_x_discount_attributes: {buy_x_condition: 5, discount_price: 499.99}}
product.save

# Scenario 3
product = Product.where(sku: "mbp").first
product.promotion_attributes = {name: "Bundle", status: 'active', buy_x_take_y_attributes: {buy_x_condition: 1, product_id: Product.where(sku: "vga").first.id}}
product.save