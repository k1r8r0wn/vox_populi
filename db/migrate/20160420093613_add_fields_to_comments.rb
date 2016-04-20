class AddFieldsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :root_comment_id, :integer, index: true
  end
end
