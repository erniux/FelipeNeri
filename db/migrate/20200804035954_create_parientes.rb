class CreateParientes < ActiveRecord::Migration[6.0]
  def change
    create_table :parientes do |t|
      t.string :nombre
      t.string :ap_paterno
      t.string :ap_materno
      t.date :fecha_nacimiento
      t.string :ocupacion
      t.string :parentesco
      t.string :calle
      t.string :numero
      t.string :interior
      t.string :colonia
      t.string :municipio
      t.string :estado
      t.string :telefono_fijo
      t.string :telefono_celular
      t.string :telefono_recados   
      t.references :internos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
