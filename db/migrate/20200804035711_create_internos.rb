class CreateInternos < ActiveRecord::Migration[6.0]
  def change
    create_table :internos do |t|
      t.string :nombre
      t.string :ap_paterno
      t.string :ap_materno
      t.date :fecha_nacimiento
      t.string :calle
      t.string :numero
      t.string :interior
      t.string :colonia
      t.string :municipio
      t.string :estado
      t.string :telefono_fijo
      t.string :telefono_celular
      t.string :telefono_otro
      t.string :nacionalidad
      t.string :estado_civil
      t.string :escolaridad
      t.string :ocupacion

      t.timestamps
    end
  end
end
