class RenameTratamientoInterno < ActiveRecord::Migration[6.0]
  def change
  	rename_table :tratamiento_internos, :tratamientos
  end
end
