class AddColumnCodigoPostalToInterno < ActiveRecord::Migration[6.0]
  def change
    add_column :internos, :codigo_postal, :string
  end
end
