class AddColumnsToEgresos < ActiveRecord::Migration[6.0]
  def change
    add_column :egresos, :usuario, :boolean
    add_column :egresos, :familiar, :boolean
    add_column :egresos, :concluido, :boolean
    add_column :egresos, :autoridad, :boolean
    add_column :egresos, :referencia, :boolean
    add_column :egresos, :abandono, :boolean
    add_column :egresos, :defuncion, :boolean
  end
end
