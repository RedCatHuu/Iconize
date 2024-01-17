class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :group_id
      t.text :caption

      t.timestamps
    end
  end
end
