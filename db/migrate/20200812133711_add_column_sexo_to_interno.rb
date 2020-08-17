class AddColumnSexoToInterno < ActiveRecord::Migration[6.0]
  def change
    add_column :internos, :sexo, :string
  end
end
