class AddColumnToEgresos < ActiveRecord::Migration[6.0]
  def change
    add_column :egresos, :fecha_egreso, :date
  end
end
