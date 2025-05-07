class DashboardTileSerializer < ActiveModel::Serializer
  attributes :name, :page_name, :count

  def count
    if respond_to?(object.page_name, true)
      23
    else
      nil
    end
  end

  def customers
    scope.customers_count
  end

  def orders
    scope.orders_count
  end

  def carts
    scope.carts_count
  end
end
