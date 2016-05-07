class AddRuNameColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ru_name, :string
  end
end
