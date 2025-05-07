class AddUserStampsToAll < ActiveRecord::Migration[6.0]
  def change
    add_column :address_details, :created_by, :integer
    add_column :address_details, :updated_by, :integer

    add_column :brands, :created_by, :integer
    add_column :brands, :updated_by, :integer

    add_column :cart_items, :created_by, :integer
    add_column :cart_items, :updated_by, :integer

    add_column :carts, :created_by, :integer
    add_column :carts, :updated_by, :integer

    add_column :dealers, :created_by, :integer
    add_column :dealers, :updated_by, :integer

    add_column :delivery_boys, :created_by, :integer
    add_column :delivery_boys, :updated_by, :integer

    add_column :delivery_tasks, :created_by, :integer
    add_column :delivery_tasks, :updated_by, :integer

    add_column :fcm_registration_ids, :created_by, :integer
    add_column :fcm_registration_ids, :updated_by, :integer

    add_column :fcm_topic_registrations, :created_by, :integer
    add_column :fcm_topic_registrations, :updated_by, :integer

    add_column :fcm_topics, :created_by, :integer
    add_column :fcm_topics, :updated_by, :integer

    add_column :locations, :created_by, :integer
    add_column :locations, :updated_by, :integer

    add_column :manual_notifications, :created_by, :integer
    add_column :manual_notifications, :updated_by, :integer

    add_column :order_items, :created_by, :integer
    add_column :order_items, :updated_by, :integer

    add_column :order_razor_pay_informations, :created_by, :integer
    add_column :order_razor_pay_informations, :updated_by, :integer

    add_column :order_reviews, :created_by, :integer
    add_column :order_reviews, :updated_by, :integer

    add_column :orders, :created_by, :integer
    add_column :orders, :updated_by, :integer

    add_column :posters, :created_by, :integer
    add_column :posters, :updated_by, :integer

    add_column :product_variant_versions, :created_by, :integer
    add_column :product_variant_versions, :updated_by, :integer

    add_column :product_variants, :created_by, :integer
    add_column :product_variants, :updated_by, :integer

    add_column :products, :created_by, :integer
    add_column :products, :updated_by, :integer

    add_column :published_notifications, :created_by, :integer
    add_column :published_notifications, :updated_by, :integer

    add_column :razorpay_payments, :created_by, :integer
    add_column :razorpay_payments, :updated_by, :integer

    add_column :reference_data, :created_by, :integer
    add_column :reference_data, :updated_by, :integer

    add_column :user_favourite_products, :created_by, :integer
    add_column :user_favourite_products, :updated_by, :integer

    add_column :users, :created_by, :integer
    add_column :users, :updated_by, :integer

    add_column :variants, :created_by, :integer
    add_column :variants, :updated_by, :integer

    add_column :week_patterns, :created_by, :integer
    add_column :week_patterns, :updated_by, :integer
  end
end
