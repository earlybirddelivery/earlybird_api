class AddDealerToTask < ActiveRecord::Migration[6.0]
  def change
    add_reference :delivery_tasks, :dealer, foreign_key: true
  end
end
