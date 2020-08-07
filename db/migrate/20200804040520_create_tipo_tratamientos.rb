class CreateTipoTratamientos < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_tratamientos do |t|
      t.text :descripcion

      t.timestamps
    end
  end
end
