class CreateMotivoSalidas < ActiveRecord::Migration[6.0]
  def change
    create_table :motivo_salidas do |t|
      t.text :descripcion

      t.timestamps
    end
  end
end
