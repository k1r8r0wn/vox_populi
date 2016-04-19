class ChangeFieldTypeInThemes < ActiveRecord::Migration
  def change
    change_column :themes, :content, :text
  end
end
