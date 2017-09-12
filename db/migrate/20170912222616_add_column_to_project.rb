class AddColumnToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :term_for_grep, :string
  end
end
