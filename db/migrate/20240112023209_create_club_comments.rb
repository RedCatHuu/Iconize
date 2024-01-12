class CreateClubComments < ActiveRecord::Migration[6.1]
  def change
    create_table :club_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :club, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
