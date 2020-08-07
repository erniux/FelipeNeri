class Interno < ApplicationRecord
	has_many :ingresos
	has_many :egresos
	has_many :parientes
	has_many :tratamientos 
end
