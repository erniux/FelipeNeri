class RemoveReferenceEgresos < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :egresos, :motivo_salidas, index: true, foreign_key: true
  	remove_reference :egresos, :tratamiento_interno, index: true, foreign_key: true
  end
end
