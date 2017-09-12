class AddColumnsToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :path, :string
    add_column :projects, :port, :string
    add_column :projects, :environment, :string
  end
end
