class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.references :category,        index: true, foreign_key: true
      t.string :title,               null: false, default: ""
      t.string :content,             null: false, default: ""
      t.timestamps                   null: false
    end
  end
end
