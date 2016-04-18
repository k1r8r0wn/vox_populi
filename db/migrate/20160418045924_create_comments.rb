class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string   :content
      t.integer  :user_id
      t.integer  :theme_id

      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_index :comments, :theme_id
  end
end
