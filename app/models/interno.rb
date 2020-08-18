class Interno < ApplicationRecord
	has_many :ingresos
	has_many :egresos
	has_many :parientes
	has_many :tratamientos 

	validates_presence_of :nombre, :ap_paterno, :ap_materno, :fecha_nacimiento, :calle, :numero, :colonia, 
	                      :municipio, :estado, :telefono_fijo, :telefono_celular, :nacionalidad, 
	                      :estado_civil, :escolaridad, :ocupacion, :sexo

	has_one_attached :documento                     		 
end
