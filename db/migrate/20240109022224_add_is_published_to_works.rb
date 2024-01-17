class AddIsPublishedToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :is_published, :boolean, null: false, default: true
  end
end
