class RenameColumnName2 < ActiveRecord::Migration[6.1]
  def change
    rename_column :works, :group_id, :club_id
  end
end
