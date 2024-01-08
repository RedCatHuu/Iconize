class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :work_id, null: false
      t.integer :user_id, null: false
      t.integer :type,    null: false
      t.text :comment,    null: false

      t.timestamps
    end
  end
end
