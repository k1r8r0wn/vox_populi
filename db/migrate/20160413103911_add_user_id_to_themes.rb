class AddUserIdToThemes < ActiveRecord::Migration
  def change
    change_column :themes, :content, :string, :text
  end
end
