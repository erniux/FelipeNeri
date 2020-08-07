class AddNombreToTratamientoInterno < ActiveRecord::Migration[6.0]
  def change
    add_column :tratamiento_internos, :nombre_tratamiento, :string
  end
end
