class CreatePosters < ActiveRecord::Migration[6.0]
  def change
    create_table :posters do |t|
      t.integer :display_order
      t.timestamps
    end
  end
end
