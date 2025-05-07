class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :customer, foreign_key: true, null: true
    add_foreign_key :oauth_access_grants, :users, column: :resource_owner_id, name: :fk_oauth_access_grants_users
    add_foreign_key :oauth_access_tokens, :users, column: :resource_owner_id, name: :fk_oauth_access_tokens_users
  end
end
