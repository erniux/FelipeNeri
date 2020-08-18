class Egreso < ApplicationRecord
  belongs_to :interno

  validates_presence_of :diagnostico_egreso,  :observaciones_egreso,  :fecha_egreso

  has_one_attached :documento
end
