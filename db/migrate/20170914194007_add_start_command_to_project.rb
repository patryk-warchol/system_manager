class AddStartCommandToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :start_cmd, :string
  end
end
