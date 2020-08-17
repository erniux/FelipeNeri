class IngresoPdf < Prawn::Document
	def initialize(interno)
		super(top_margin: 70)
		@interno = interno
		 titulos("HOJA DE INGRESO", 235, 635)
		 ingreso
		 familiar
		 criterios

		 start_new_page
		 titulos("CONSENTIMIENTO INFORMADO PARA MAYORES DE EDAD",  180, 635)
		 consentimiento

		 start_new_page
		 titulos("CONDICIONES", 253, 635)
		 condiciones

		 start_new_page
		 titulos("DERECHOS DEL PACIENTE", 220, 635)
		 derechos
	end

	def titulos(hoja, x, y)
		top_layer = "#{Rails.root}/app/assets/images/logo.jpg"
		image top_layer, :at => [50,700], :width => 75
		draw_text "CLINICA DE REHABILITACION CONTRA LAS ADDICCIONES", size: 10, style: :bold, at: [150,680]
 		draw_text "FELIPE NERI", size: 10, style: :bold, at: [250, 665]
 		draw_text  hoja, size: 8, style: :bold, at: [x, y]
 		 
 		line [0, 610], [550,610], line_color: '337DFF', width: 5, inline_format: true
 		stroke do
			stroke_color '337DFF'
    		self.line_width = 5
		end
	end

	def expediente
		draw_text "Expediente \##{@interno.id}", size: 8, style: :bold, at: [390,600]
	end

	def ingreso
		draw_text "Fecha y hora del ingreso", size: 8, style: :bold,  at: [0,600]
		draw_text "#{@interno.ingresos.last.fecha_hora.strftime("%d/%m/%Y %H:%M")}", size: 8, at: [120,600]
		expediente
		draw_text "1. Datos del Usuario", size: 10, style: :bold, at: [0,575]
		draw_text "Nombre completo del usuario: ", size: 8, style: :bold,  at: [0,560]
		draw_text "#{@interno.nombre + '  ' + @interno.ap_paterno + '  ' + @interno.ap_materno}", size: 8, at: [140,560]
		draw_text "Sexo:", size: 8, style: :bold, at: [0,545]
		draw_text "#{@interno.sexo}", size: 8, at: [40,545]
		draw_text "Fecha de nacimiento:", size: 8, style: :bold, at: [180,545]
		draw_text "#{@interno.fecha_nacimiento.strftime("%d/%m/%Y")}", size: 8, at: [280,545]
		draw_text "Edad:", size: 8, style: :bold, at: [430,545]
		edad(@interno.fecha_nacimiento, 470, 545)
		draw_text "Dirección:", size: 8, style: :bold, at: [0,530]
		draw_text "#{@interno.calle + ' No. ' + @interno.numero + ' ' + @interno.interior + ', Col. ' + @interno.colonia + ', ' + @interno.municipio + ', ' + @interno.estado}",
				  size: 8, at: [50,530]
		draw_text "Teléfono(s):", size: 8, style: :bold, at: [0,515]
		draw_text "#{ @interno.telefono_fijo.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3') + ', ' + 
					  @interno.telefono_celular.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3') + ', ' + 
					  @interno.telefono_otro.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3')}",
		          	  size: 8, at: [60, 515]
		draw_text "Nacionalidad:", size: 8, style: :bold, at: [0,500]
		draw_text "#{@interno.nacionalidad}", size: 8, at: [80,500]
		draw_text "Estado civil:", size: 8, style: :bold, at: [220,500]
		draw_text "#{@interno.estado_civil}", size: 8, at: [300,500]
		draw_text "Escolaridad:", size: 8, style: :bold, at: [0,485]
		draw_text "#{@interno.escolaridad}", size: 8, at: [80,485]
		draw_text "Ocupación:", size: 8, style: :bold, at: [220,485]
		draw_text "#{@interno.ocupacion}", size: 8, at: [300,485]
		draw_text "¿Cuántos ingresos previos ha tenido en el establecimiento?", size: 8, style: :bold, at: [0,470]
		draw_text "#{@interno.ingresos.count - 1}", size: 8, at: [300,470]
		actual_ingreso = @interno.ingresos.order(fecha_hora: :desc).last.fecha_hora
 		#Obtener la fecha del penultimo ingreso  y anteriores
 		@interno.ingresos.order(fecha_hora: :desc).each do |ingreso|
 			if ingreso.fecha_hora < actual_ingreso
 				draw_text "#{ingreso.fecha_hora.strftime("%d/%m/%Y %H:%M") + ' '}", size: 8, at: [200,470]
 			end
 		end
		draw_text "¿Lo refiere alguna institución?", size: 8, style: :bold, at: [0,455]
		text_si_no(@interno.ingresos.last.referido_institucion, 200,455) 
		if @interno.ingresos.last.referido_institucion
			draw_text "¿Cual?", size: 8, style: :bold, at: [300,455]
			draw_text "#{@interno.ingresos.last.institucion_referencia}",size:9, at: [350,455]
			draw_text "¿Presenta hoja de referencia?", size: 8, style: :bold, at: [0,440]
		end
		draw_text "Tipo de ingreso actual:", size: 8, style: :bold, at: [0, 425]
		draw_text "#{@interno.ingresos.last.tipo_ingreso}", size: 8, at: [200,425]
		draw_text "Motivo de consulta:", size: 8, style: :bold, at: [0,410]
		text_box "#{@interno.ingresos.last.motivo_ingreso}", size: 8, width: 545, at: [0, 400], align: :justify
		draw_text "Descripción breve del estado de salud general del usuario:", size: 8, style: :bold, at: [0,350]
		text_box "#{@interno.ingresos.last.descripcion_estado_salud}", size: 8, width: 545, at: [0, 340], align: :justify
	           
	end

	def edad(fecha, x, y)
		draw_text "#{((Time.zone.now - fecha.to_time) / 1.year.seconds).floor}", size: 8, at: [x,y]
	end

	def calc_edad(fecha)
		((Time.zone.now - fecha.to_time) / 1.year.seconds).floor
	end


	def familiar
		draw_text "2. Datos del familiar o representante legal", size: 10, style: :bold, at: [0,290]
		draw_text "Nombre:", size: 8, style: :bold, at: [0, 275]
		draw_text "#{@interno.parientes.first.nombre + ' ' +  @interno.parientes.first.ap_paterno + ' ' + @interno.parientes.first.ap_materno}",
		          size:8, at: [140,275]
		draw_text "Edad:", size: 8, style: :bold, at: [0,260]
		edad(@interno.parientes.first.fecha_nacimiento, 140, 260)
		draw_text "Ocupación:", size: 8, style: :bold, at: [200,260]
		draw_text "#{@interno.parientes.first.ocupacion}", size: 8, at: [260,260]
		draw_text "Parentesco:", size: 8, style: :bold, at: [350,260]
		draw_text "#{@interno.parientes.first.parentesco}", size: 8, at: [400,260]
		draw_text "Dirección:", size: 8, style: :bold, at: [0,245]
		draw_text "#{@interno.parientes.first.calle + ' No. ' + @interno.parientes.first.numero + ' ' + @interno.parientes.first.interior + ', Col. ' + @interno.parientes.first.colonia + ', ' + @interno.parientes.first.municipio + ', ' + @interno.parientes.first.estado}",
				  size: 8, at: [50,245]
		draw_text "Teléfono(s):", size: 8, style: :bold, at: [0,230]
		draw_text "#{ @interno.parientes.first.telefono_fijo.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3') + ', ' + 
					  @interno.parientes.first.telefono_celular.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3') + ', ' + 
					  @interno.parientes.first.telefono_recados.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3')}",
		          	  size: 8, at: [60, 230]
	end

	def criterios
		draw_text "3. Criterios clínicos de inclusión al tratamiento", size: 10, style: :bold, at: [0,200]
		draw_text "¿El usuario es hombre?", size:8, style: :bold, at: [0,185]
		text_si_no(@interno.ingresos.last.hombre, 480,185)
		draw_text "¿El usuario es mayor de edad?", size:8, style: :bold, at: [0,170]
		text_si_no(@interno.ingresos.last.mayor_edad, 480,170)
		draw_text "¿El usuario presenta un nivel de dependencia al alcohol o drogas?", size:8, style: :bold, at: [0,155]
		text_si_no(@interno.ingresos.last.dependencias, 480,155)
		draw_text "¿El usuario presenta alguna(s) consecuencia(s) asociada(s) al consumo?", size:8, style: :bold, at: [0,140]
		text_si_no(@interno.ingresos.last.consecuencias, 480,140)
		draw_text "¿El usuario presenta algun transtorno mental o psiquiátrico que le impida beneficiarse del tratamiento?", size:8, style: :bold, at: [0,125]
		text_si_no(@interno.ingresos.last.transtorno_mental, 480,125)
		draw_text "El usuario cumple con todos los criterios de admisión del tratamiento?", size:8, style: :bold, at: [0,110]
		text_si_no(@interno.ingresos.last.cumple, 480,110)
		draw_text "En caso de no haber cumplido los criterios, indicar el lugar al que será referido:", size:8, style: :bold, at: [0,95]
		draw_text "#{@interno.ingresos.last.referirlo }", size: 8, at: [310,95]
		draw_text "#{@interno.ingresos.last.nombre_entrevistador}", size: 8, at: [0,60]
		draw_text "Nombre y Firma Entrevistador", size: 8, style: :bold, at: [0, 50]
		draw_text "Cargo", size: 8, style: :bold, at: [0, 40]
		draw_text "#{@interno.ingresos.last.cargo_entrevistador}", size: 8, at: [50,40]
	end

	def text_si_no(valor,x,y)
		if valor
			draw_text "(X) SI   ( ) NO", size: 8, at: [x,y] 
		else
			draw_text "( ) SI   (X) NO", size: 8, at: [x,y] 
		end
	end

	def consentimiento
		stroke do
			stroke_color '020202'
    		self.line_width = 1
		end
		expediente
		draw_text "Por parte del usuario:", size: 8, style: :bold,  at: [0,580]
		text_box " Por medio de la presente, Yo: #{@interno.nombre + ' ' + @interno.ap_paterno + ' ' + @interno.ap_materno}, de sexo #{@interno.sexo} con #{calc_edad(@interno.fecha_nacimiento)} años de edad, declaro haber sido informado que el establecimiento:  <u>CLINICA FELIPE NERI</u> ubicado en: <u>CALLE 51 No. 814, COL. LOMAS DE CASA BLANCA</u> ofrece un tratamiento residencial por un tiempo de: #{@interno.ingresos.last.duracion} semanas que tiene la finalidad de brindar atención para mi consumo de alcohol y/o drogas. Dicho tratamiento se basa en un modelo de tratamiento: AYUDA MUTUA 12 PASOS A.A. cuyo objetivo consiste en: <u><b>REINSERCIÓN SOCIAL Y ABANDONO DEL CONSUMO DE SUSTANCIAS TÓXICAS.</b></u>\n\nEstoy de acuerdo en participar activamente durante. todo el proceso de tratamiento, lo que implica proporcionar información veraz y fidedigna al momento de la evaluación, realizar las actividades asignadas por el conseejero, médico y/o psicólogo, cumplir los puntos que establece el reglamento interno respecto a mi comportamiento y asistir a las sesiones de seguimiento una vez terminado el tratamiento, todo ello en beneficio de lograr mi abstinencia y facilitar mi recuperación. Acepto que en caso necesario y al no obtener los resultados esperados, se me proporcione información por escrito respecto a otro tipo de alternativas de atención.\n\n Tengo conocimiento que la relación de mi persona con el personal del establecimiento, será únicamente profesional. \n\n Por otra parte, me comprometo a cumplir con una cuota : <b><u>DE INGRESO Y SEMANAL</u></b> de: $__________ Y $________, en beneficio de tener acceso a servicios dignos y apropiados durantee mi estancia. En el caso de cancelar mi permanencia antes de haber cumplido con el período de tratamiento, estoy de acuerdo en: <b><u>CUBRIR EL TOTAL. DEL ADEUDO DEL TRATAMIENTO.</u></b>\n\n  Ratifico que he. sido informado respecto a las características del tratamiento, los procedimientos, los riesgos que implica, los costos, así como los beneficios esperados y. estoy. de acuerdo en los requerimientos necesarios para su aplicación.\n\n <b>Por parte del establecimiento</b>\n El establecimiento: <b><u>LA CLÍNICA FELIPE NERI</u></b> se compromete. a brindar un servicio de. atención de calidad que facilite la recuperación y la reinserción del usuario a una vida productiva, garantizando en todo momento el respeto a su integridad y haciendo valer sus derechos. Por ello, el caso que el usuario desee suspender el tratamiento antes que este finalice, el centro se compromete a no mantenerlo de forma involuntaria y a brindarle la información y  la orientación necesaria para continuar con el proceso de rehabilitación en otra. instancia.\n\n Se pone de manifiesto que toda información brindada por el usuario es de carácter. confidencias y.  solo tendrán acceso a esta el equipo multidisciplinario involucrado en el proceso terapéutico, por lo que no se revelará a ningún otro individuo, si no es bajo consentimiento escrito del usuario. En el caso que el usuario presente una condición médica previa al ingreso, el establecimiento dará continuidad al tratamiento médico o farmacológico, suministrando los medicamentos en las dosis y. horarios indicados, siempre y cuando éstos sean proporcionados por: <b><u>UN MÉDICO Y/O FAMILIAR</u></b> y existan los estudios y recetas avaladas por un médico certificado y. no se contraindique con el tratamiento recibido durante la estancia. En caso que el usuario requiera estudios complementarios o el servicio de un médico especializado, se le informará al respecto y se dará aviso a los familiares.\n\n En caso que el usuario requiera atención médica urgente, se dará aviso a los familiares y se trasladará a algún hombrespital del segundo nivel para su atención. Por otro lado, el establecimiento se exime de toda responsabilidad por los actos en contra de la ley en que el usuario se haya visto involucrado, previo y posterior al tratamiento.\n\n En el caso que el usuario o sus familiares presenten alguna duda respecto al proceso de rehabilitación se compromete a proporcionar y a dar lectura del reglamento interno del establecimiento al usuario, familiar y/o representante legal.\n\n Siendo las #{I18n.localize(Time.zone.now, format: '%k:%M hrs. del %d de %B del %Y')} en _____________ y habiendo sido informado y aceptado los compromisos anteriormente expuestos y, firman el presente consentimiento:" , inline_format: true, size: 8, width: 545, at: [0, 550], align: :justify
 			
			 
  			stroke_line [0, 110], [150, 110]
  			draw_text "nombre y firma del usuario", size: 8, at: [20,100]
  			 
  			stroke_line [300, 110], [450,110]	
  			draw_text "nombre y firma del famiiliar", size: 8, at: [320,100]
  			 
			stroke_line [0, 70], [150, 70]
  			draw_text "nombre y firma del director y/o encargado", size: 8, at: [0,60]
  			 
  			stroke_line [300, 70], [450,70]	
  			draw_text "nombre y firma del 1er testigo", size: 8, at: [320,60]

  			stroke_line [140, 20], [290,20]	
  			draw_text "nombre y firma del 2er testigo", size: 8, at: [160,10]
	end

	def condiciones
		stroke do
			stroke_color '020202'
    		self.line_width = 1
		end
		draw_text "* PROVEER LOS ARTICULOS PERSONALES DEL USUARIO", size: 8, style: :bold,  at: [150,550]
		draw_text "* ENTREGAR LA DESPENSA SEMANAL CON PUNTUALIDAD", size: 8, style: :bold,  at: [150,530]
		draw_text "* PAGO PUNTUAL DE LA CUOTA SEMANAL", size: 8, style: :bold,  at: [150,510]
		draw_text "* ASISTENCIA A LAS VISITAS FAMILIARES", size: 8, style: :bold,  at: [150,490]
		draw_text "* MANTENERSE INFORMADO DE LAS NECESIDADES Y ESTADO FISICO DEL USUARIO", size: 8, style: :bold,  at: [150,470]
		draw_text "* PROVEER LOS MEDICAMENTOS INDICADOS EN LA RECETA. MEDICA", size: 8, style: :bold,  at: [150,450]
		text_box "* RESPETAR EL TIEMPO DE INTERNAMIENTO DE __ MESES Y EN CASO DE NO RESPETAR DICHO ACUERDO, SE COMPROMETE A CUBRIR EL TOTAL DE. LAS. CUOTAS FALTANTES HASTA. EL DIA DE TERMINO DEL TRATAMIENTO", size: 8, style: :bold, width: 400,  at: [150,430]
		text_box "\n\nASI MISMO, EL RESPONSABLE DESLINDA DE TODA RESPONSABILIDAD CIVIL Y/O PENAL A LA CLÍNICA DE REHABILITACIÓN FELIPE NERI, ASI COMO SU STAFF. TERAPEUTICO Y MIEMBROS DE ESTE CENTRO DE REHABILITACIÓN POR MUERTE. O COMPLICACIONES POR. ENFERMEDAD DEL ALCOHOLISMO O DROGADICCIÓN U OTRAS ENFERMEDADES O ACCIDENTES OCURRIDOS DENTRO O FUERA DE ESTE CENTRO DE REHABILITACIÓN. \n\n POR PARTE DE LOS RESPONSABLES DE LA CLÍNICA DE REHABILITACIÓN FELIPE NERI NO NOS HACEMOS RESPONSABLES TANTO FÍSICA Y MENTALMENTE. DEL USUARIO EN INTENTO DE FUGA. \n\n ACEPTO LAS CONDICIONES ASI COMO EL REGLAMENTO INTERNO DE LA CLÍNICA DE REHABILITACIÓN FELIPE NERI.", size: 8, width: 545, at: [0,410], align: :justify

			stroke_line [0, 210], [150, 210]
  			draw_text "nombre y firma del usuario", size: 8, at: [20,200]
  			 
  			stroke_line [300, 210], [450,210]	
  			draw_text "nombre y firma del famiiliar", size: 8, at: [320,200]
  			 
			stroke_line [0, 170], [150, 170]
  			draw_text "nombre y firma del director y/o encargado", size: 8, at: [0,160]
  			 
  			stroke_line [300, 170], [450,170]	
  			draw_text "nombre y firma del 1er testigo", size: 8, at: [320,160]
	end

	def derechos
		stroke do
			stroke_color '020202'
    		self.line_width = 1
		end
		text_box "* RECIBIR UN TRATO DIGNO Y HUMANO POR PARTE DEL ESTABLECIIMIENTO, INDEPENDIENTEMENTE DE SU DIAGNÓSTICO, SITUACÓN SOCIAL O ECONÓMICA, SEXO, ETNIA, IDEOLOGIA O RELIGIÓN.\n\n * NO SER SOMETIDOS A. RESTRICCIONES FÍSICAS O MALTRATOS.\n\n * A SU INGRESO, ES OBLIGATORIO INFORMAR. A SU FAMILIAR Y/O REPRESENTANTE LEGAL, TANTO DE LAS NORMAS QUE RIGEN EN EL CENTRO DE TRATAMIENTO.\n\n * NO SER SUJETOS A DISCRIMINACIÓN POR SU CONDICIÓN DE ENFERMOS ADICTOS. \n\n *RECIBIR. TRATAMIENTO, INFORMACIÓN Y ORIENTACIÓN PARA. SU REINTEGRACIÓN A LA VIDA FAMILIAR, LABORAL Y SOCIAL. \n\n * AL INGRESAR AL ESTABLECIMIENTO DEBERÁ SER VALORADO POR UN MÉDICO. \n\n *QUE LA INFORMACIÓN PROPORCIONADA POR EL PACIENTE O SUS FAMILIARES Y LA CONTENIDA EN SU EXPEDIENTE CLÍNICO SEA MANEJADA BAJO NORAMAS DE CONFIDENCIALIDAD.\n\n * QUE TODO MEDICAMENTO SEA PRESCRITO POR UN PROFESIONAL Y SE REGISTRE EN EL EXPEDIENTE CLÍNICO DEL PACIENTE. ", size: 8, width: 500, at: [0,580], align: :justify

			stroke_line [0, 310], [150, 310]
  			draw_text "NOMBRE Y FIRMA DEL USUARIO", size: 8, at: [20,300]
  			 
  			stroke_line [300, 310], [450,310]	
  			draw_text "NOMBRE Y FIRMA DEL FAMILIAR", size: 8, at: [310,300]
  			 
  			stroke_line [140, 260], [290,260]	
  			draw_text "RESPONSABLE DEL CENTRO. DE REHABILITACION", size: 8, at: [120,250]
	end

end