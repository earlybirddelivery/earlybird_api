# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Doorkeeper::Application.find_by(name: 'earlybird_user_mobile')
  Doorkeeper::Application.create!(name: 'earlybird_user_mobile',
                                  redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
                                 )
end
unless Doorkeeper::Application.find_by(name: 'earlybird_admin_web')
  Doorkeeper::Application.create!(name: 'earlybird_admin_web',
                                  redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
                                 )
end
unless Doorkeeper::Application.find_by(name: 'earlybird_delivery_mobile')
  Doorkeeper::Application.create!(name: 'earlybird_delivery_mobile',
                                  redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
                                 )
end

ReferenceDatum.create_unless_found!(:user_role, 'key_super_admin', 'SuperAdmin')
ReferenceDatum.create_unless_found!(:user_role, 'key_admin', 'Admin')
ReferenceDatum.create_unless_found!(:user_role, 'key_customer', 'Customer')
ReferenceDatum.create_unless_found!(:user_role, 'key_crm', 'CRM')
ReferenceDatum.create_unless_found!(:user_role, 'key_delivery_boy', 'Delivery Boy')
ReferenceDatum.create_unless_found!(:variant_type, 'Key_grams', 'Grams', 1, 'g')
ReferenceDatum.create_unless_found!(:variant_type, 'key_kilo_grams', 'KiloGrams', 1, 'kg')
ReferenceDatum.create_unless_found!(:variant_type, 'key_liters', 'Liters', 1, 'l')
ReferenceDatum.create_unless_found!(:variant_type, 'key_milli_liters', 'Milli Liters', 1, 'ml')
ReferenceDatum.create_unless_found!(:variant_type, 'key_pack', 'Pack', 1, 'pack')
ReferenceDatum.create_unless_found!(:category_type, 'key_fruits_and_vegitables', 'Fruits and Vegitables')
ReferenceDatum.create_unless_found!(:category_type, 'key_dairy_products', 'Dairy Products')
ReferenceDatum.create_unless_found!(:category_type, 'key_groceries', 'Groceries')
ReferenceDatum.create_unless_found!(:category_type, 'key_dry_fruits', 'Dry Fruits')
ReferenceDatum.create_unless_found!(:category_type, 'key_recipes', 'Recipes')
ReferenceDatum.create_unless_found!(:category_type, 'key_water_supply', 'Water Supply')
ReferenceDatum.create_unless_found!(:category_type, 'key_pickels', 'Pickels')
Poster.find_or_create_by!(display_order: 1)
Poster.find_or_create_by!(display_order: 2)
Poster.find_or_create_by!(display_order: 3)
Poster.find_or_create_by!(display_order: 4)
Poster.find_or_create_by!(display_order: 5)

ReferenceDatum.create_unless_found!(:delivery_task_status_type, 'key_ongoing', 'Ongoing', 1)
ReferenceDatum.create_unless_found!(:delivery_task_status_type, 'key_assigned', 'Assigned', 2)
ReferenceDatum.create_unless_found!(:delivery_task_status_type, 'key_completed', 'Completed', 3)
ReferenceDatum.create_unless_found!(:delivery_task_status_type, 'key_cancelled', 'Cancelled', 4)
ReferenceDatum.create_unless_found!(:delivery_task_status_type, 'key_created', 'Created', 5)

ReferenceDatum.create_unless_found!(:order_status_type, 'key_created', 'Created', 6)
ReferenceDatum.create_unless_found!(:order_status_type, 'key_order_placed', 'Order Placed', 2)
ReferenceDatum.create_unless_found!(:order_status_type, 'key_payment_pending', 'Payment Pending', 1)
ReferenceDatum.create_unless_found!(:order_status_type, 'key_out_for_delivery', 'Out for Delivery', 3)
ReferenceDatum.create_unless_found!(:order_status_type, 'key_delivered', 'Delivered', 4)
ReferenceDatum.create_unless_found!(:order_status_type, 'key_cancelled', 'Cancelled', 5)

ReferenceDatum.create_unless_found!(:order_admin_status_type, 'key_created', 'Created', 5)
ReferenceDatum.create_unless_found!(:order_admin_status_type, 'key_payment_pending', 'Payment Pending', 1)
ReferenceDatum.create_unless_found!(:order_admin_status_type, 'key_received', 'Received', 2)
ReferenceDatum.create_unless_found!(:order_admin_status_type, 'key_out_for_delivery', 'Out for Delivery', 3)
ReferenceDatum.create_unless_found!(:order_admin_status_type, 'key_delivered', 'Delivered', 4)
ReferenceDatum.create_unless_found!(:order_admin_status_type, 'key_cancelled', 'Cancelled', 5)
DashboardTile.create_unless_found!({name: 'Orders', page_name: 'orders', active: true }, 'name')
DashboardTile.create_unless_found!({name: 'Customers', page_name: 'customers', active: true}, 'name')
DashboardTile.create_unless_found!({name: 'Carts', page_name: 'carts', active: true }, 'name')
DashboardTile.create_unless_found!({name: 'Add Customer', page_name: 'add_customer', active: true }, 'name')
