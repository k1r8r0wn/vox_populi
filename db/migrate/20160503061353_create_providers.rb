class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string  :name
      t.string  :uid
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :providers, :user_id
  end
end
