class CreateEgresos < ActiveRecord::Migration[6.0]
  def change
    create_table :egresos do |t|
      t.text :diagnostico_egreso
      t.text :observaciones_egreso
      t.references :ingresos, null: false, foreign_key: true
      t.references :motivo_salidas, null: false, foreign_key: true
      t.references :tratamiento_interno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
