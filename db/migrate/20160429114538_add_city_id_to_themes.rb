class AddCityIdToThemes < ActiveRecord::Migration
  def change
    add_reference :themes, :city, index: true, foreign_key: true
  end
end
