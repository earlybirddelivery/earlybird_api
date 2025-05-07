class Product < ApplicationRecord
  belongs_to :brand
  has_many :product_variants, dependent: :destroy
  has_many :user_favourite_products, foreign_key: :favourite_product_id, dependent: :destroy, inverse_of: :user_favourite_products
  has_one_attached :display_pic, dependent: :destroy
  attr_accessor :favourite_product

  accepts_nested_attributes_for :product_variants, allow_destroy: true

  def self.filter(params, super_list_access)
    query = []
    query_params = {}
    params[:active] = super_list_access ? params[:active] : true
    add_active_filter(params[:active], query, query_params)
    add_brand_filter(params[:brand_id], query, query_params) if params[:brand_id]
    add_exclusive_offer_filter(params[:in_exclusive_offer], query, query_params) if params[:in_exclusive_offer]
    add_best_selling_filter(params[:in_best_selling], query, query_params) if params[:in_best_selling]
    final_query = query.join(' and ')
    products = Product.where(final_query, query_params)
    products.reorder('products.priority asc, products.created_at desc').includes(display_pic_attachment: :blob).includes(:product_variants)
            .order('product_variants.default desc')
  end

  def display_pic_url
    return unless display_pic.attached?

    display_pic.url
  end

  def ordered_product_variants
    product_variants.order_records
  end

  def self.add_active_filter(active, query, query_params)
    query << 'products.active = :active'
    query_params[:active] = active
  end

  def self.add_brand_filter(brand_id, query, query_params)
    query << 'brand_id = :brand_id'
    query_params[:brand_id] = brand_id
  end

  def self.add_exclusive_offer_filter(in_exclusive_offer, query, query_params)
    query << 'in_exclusive_offer = :in_exclusive_offer'
    query_params[:in_exclusive_offer] = in_exclusive_offer
  end

  def self.add_best_selling_filter(in_best_selling, query, query_params)
    query << 'best_selling = :in_best_selling'
    query_params[:in_best_selling] = in_best_selling
  end
end
