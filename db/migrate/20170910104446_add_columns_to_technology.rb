class AddColumnsToTechnology < ActiveRecord::Migration[5.1]
  def change
    add_column :technologies, :get_cmd, :string
  end
end
