class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :filename
      t.string :url
      t.references :store, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
