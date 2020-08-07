class RemoveReferenceToTratamientoInternos < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :tratamiento_internos, :tipo_tratamiento,  index: true, foreign_key: true
  end
end

 	