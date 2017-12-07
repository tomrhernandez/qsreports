class UsersHaveAndBelongToManyStores < ActiveRecord::Migration
  def change
    create_table :stores_users, :id => false do |t|
      t.references :user, :store
      
    end
  end
end
