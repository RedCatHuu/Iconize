class CreateClubs < ActiveRecord::Migration[6.1]
  def change
    create_table :clubs do |t|
      t.integer :owner, null: false
      t.string :name,   null: false
      t.text :introduction

      t.timestamps
    end
  end
end
