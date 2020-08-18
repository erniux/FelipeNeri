class Ingreso < ApplicationRecord
  belongs_to :interno

  validates_presence_of :fecha_hora,  :tipo_ingreso, 
  						:motivo_ingreso, :descripcion_estado_salud, :nombre_entrevistador, :cargo_entrevistador
  
  has_one_attached :documento						
end
