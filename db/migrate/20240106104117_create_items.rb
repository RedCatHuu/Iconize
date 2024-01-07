class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :work_id, null: false
      t.string :genre,    null: false

      t.timestamps
    end
  end
end
