class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.references :category,        index: true, foreign_key: true
      t.string :title,               null: false, default: ""
      t.text :content,               null: false, default: ""
      t.integer :user_id
      t.timestamps                   null: false
    end
  end
end
