class AddShortCutKeyForReferenceData < ActiveRecord::Migration[6.0]
  def change
    add_column :reference_data, :short_key, :string
  end
end
