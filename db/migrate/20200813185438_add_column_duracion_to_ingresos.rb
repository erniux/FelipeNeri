class AddColumnDuracionToIngresos < ActiveRecord::Migration[6.0]
  def change
    add_column :ingresos, :duracion, :integer
  end
end
