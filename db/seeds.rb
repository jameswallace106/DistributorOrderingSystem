products = Product.create!([
  { name: "Apple" },
  { name: "Banana" },
  { name: "Orange" },
  { name: "Kiwi" }
])

distributors = Distributor.create!([
  { name: "Uganda" },
  { name: "China" },
  { name: "Peru" },
  { name: "Botswana" }
])

admin = Admin.create!(name: "ADMIN")

User.create!(
  username: "ADMIN",
  password: "Beans",
  password_confirmation: "Beans",
  is_admin: true,
  admin: admin
)

User.create!(
  username: "DIST",
  password: "Beans",
  password_confirmation: "Beans",
  is_admin: false,
  distributor: distributors[3]
)

StockKeepingUnit.create!([
  {price: 2.21, distributor_id: distributors[3].id, product_id: products[0].id},
  {price: 12.11, distributor_id: distributors[1].id, product_id: products[1].id},
  {price: 3.69, distributor_id: distributors[2].id, product_id: products[3].id},
  {price: 1.08, distributor_id: distributors[3].id, product_id: products[2].id},
  {price: 0.99, distributor_id: distributors[3].id, product_id: products[1].id},
  {price: 15.12, distributor_id: distributors[1].id, product_id: products[3].id}
])

orders = Order.create!([
  {
    distributor: distributors[3],
    required_delivery_date: Date.new(2026, 2, 26),
    status: "submitted"
  },
  {
    distributor: distributors[3],
    required_delivery_date: Date.new(2026, 2, 8),
    status: "in-progress"
  }
])

skus = StockKeepingUnit.all
Item.create!([
  {quantity: 10, stock_keeping_unit_id: skus[3].id, order_id: orders[0].id},
  {quantity: 5, stock_keeping_unit_id: skus[4].id, order_id: orders[0].id},
  {quantity: 3, stock_keeping_unit_id: skus[0].id, order_id: orders[0].id},
  {quantity: 7, stock_keeping_unit_id: skus[0].id, order_id: orders[1].id}
])