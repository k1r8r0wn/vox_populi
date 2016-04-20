class EditCommentsTable < ActiveRecord::Migration
  def change
    remove_column :comments, :commentable_id, :integer
    remove_column :comments, :commentable_type, :string
  end
end
