class RenameColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :clubs, :owner, :owner_id
  end
end
