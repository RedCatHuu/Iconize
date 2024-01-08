class AddTitleToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :title, :string, null: false
  end
end
