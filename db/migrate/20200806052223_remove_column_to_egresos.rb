class RemoveColumnToEgresos < ActiveRecord::Migration[6.0]
  def change
  	 remove_reference :egresos, :ingresos, index: true, foreign_key: true
  end
end
