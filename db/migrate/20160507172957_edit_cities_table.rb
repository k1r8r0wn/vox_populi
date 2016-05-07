class EditCitiesTable < ActiveRecord::Migration
  def change
    rename_column :cities, :title, :name
    add_column    :cities, :ru_name, :string
  end
end
