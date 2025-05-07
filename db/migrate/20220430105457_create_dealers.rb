class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :name
      t.string :area
      t.timestamps
    end
  end
end
