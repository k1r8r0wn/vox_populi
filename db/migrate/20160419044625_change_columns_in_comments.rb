class ChangeColumnsInComments < ActiveRecord::Migration
  def change
    change_column :comments, :content, :text
    remove_column :comments, :theme_id, :integer
  end
end
