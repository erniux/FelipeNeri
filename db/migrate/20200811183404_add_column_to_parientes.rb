class AddColumnToParientes < ActiveRecord::Migration[6.0]
  def change
    add_column :parientes, :representante, :boolean
  end
end
