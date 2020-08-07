class CreateIngresos < ActiveRecord::Migration[6.0]
  def change
    create_table :ingresos do |t|
      t.datetime :fecha_hora
      t.boolean :referido_institucion
      t.string :institucion_referencia
      t.boolean :hoja_referencia
      t.string :tipo_ingreso
      t.text :motivo_ingreso
      t.text :descripcion_estado_salud
      t.boolean :hombre
      t.boolean :mayor_edad
      t.boolean :dependencias
      t.boolean :consecuencias
      t.boolean :transtorno_mental
      t.boolean :cumple
      t.text :referirlo
      t.string :nombre_entrevistador
      t.string :cargo_entrevistador
      t.references :interno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
