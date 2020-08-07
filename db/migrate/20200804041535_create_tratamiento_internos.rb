class CreateTratamientoInternos < ActiveRecord::Migration[6.0]
  def change
    create_table :tratamiento_internos do |t|
      t.date :fecha_inicio
      t.date :fecha_fin
      t.integer :total_horas
      t.text :observaciones
      t.references :interno, null: false, foreign_key: true
      t.references :tipo_tratamiento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
