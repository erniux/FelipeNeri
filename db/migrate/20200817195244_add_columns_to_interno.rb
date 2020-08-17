class AddColumnsToInterno < ActiveRecord::Migration[6.0]
  def change
    add_column :internos, :servicio_medico, :boolean
    add_column :internos, :num_afiliacion, :string
  end
end
