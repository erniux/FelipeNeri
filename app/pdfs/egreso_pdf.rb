class EgresoPdf < Prawn::Document
	def initialize(interno)
		super(top_margin: 70)
		@interno = interno
		titulos("HOJA DE EGRESO", 235, 635)  
		usuario
	end

	def logo
		@imagen = Config.where(desc: 'Documentos').first.try(:logo)
		@logo = StringIO.open(@imagen.download)
		image @logo, scale: 0.10, :at => [0,700], :width => 75
	end

	def titulos(hoja, x, y)
		logo
		draw_text "CLINICA DE REHABILITACION CONTRA LAS ADDICCIONES", size: 10, style: :bold, at: [150,680]
 		draw_text "FELIPE NERI", size: 10, style: :bold, at: [250, 665]
 		draw_text  hoja, size: 8, style: :bold, at: [x, y]
 		 
 		line [0, 610], [550,610], line_color: '337DFF', width: 5, inline_format: true
 		stroke do
			stroke_color '337DFF'
    		self.line_width = 5
		end
	end

	def edad(fecha, x, y)
		draw_text "#{((Time.zone.now - fecha.to_time) / 1.year.seconds).floor}", size: 8, at: [x,y]
	end

	def calc_edad(fecha)
		((Time.zone.now - fecha.to_time) / 1.year.seconds).floor
	end

	def text_si_no(valor,x,y)
		if valor
			draw_text "(X)", size: 8, at: [x,y] 
		else
			draw_text "( )", size: 8, at: [x,y] 
		end
	end

	def usuario
		draw_text "Datos del Usuario: ", size: 8, style: :bold,  at: [0,560]
		draw_text "#{@interno.nombre + '  ' + @interno.ap_paterno + '  ' + @interno.ap_materno}", size: 8, at: [140,560]
		draw_text "Edad:", size: 8, style: :bold, at: [0,545]
		edad(@interno.fecha_nacimiento, 60, 545)
		draw_text "Sexo:", size: 8, style: :bold, at: [150,545]
		draw_text "#{@interno.sexo}", size: 8, at: [200,545]
		draw_text "Fecha de nacimiento:", size: 8, style: :bold, at: [360,545]
		draw_text "#{@interno.fecha_nacimiento.strftime("%d/%m/%Y")}", size: 8, at: [455,545]
		draw_text "Estado Civil:", size:8,  style: :bold, at: [0,530]
		draw_text "#{@interno.estado_civil}", size: 8, at: [60, 530]
		draw_text "Escolaridad:", size:8,  style: :bold, at: [150,530]
		draw_text "#{@interno.escolaridad}", size: 8, at: [200, 530]
		draw_text "Ocupación:", size:8,  style: :bold, at: [360,530]
		draw_text "#{@interno.ocupacion}", size: 8, at: [455, 530]
		draw_text "¿Cuenta con servicio médico?", size:8, style: :bold, at: [0,510]
			if @interno.servicio_medico
				draw_text "(X) SI   ( ) NO", size: 8, at: [120,510] 
				draw_text "Num. afiliación: ", size:8, style: :bold, at: [200,510] 
				draw_text "#{@interno.num_afiliacion}", size:8,  at: [270,510]
			else
				draw_text "( ) SI   (X) NO", size: 8, at: [120,510] 
			end 
		draw_text "Domicilio Particular:", size: 8, style: :bold, at: [0,490]
		draw_text "#{@interno.calle + ' No. ' + @interno.numero + ' ' + @interno.interior + ', Col. ' + @interno.colonia + ', ' + @interno.municipio + ', ' + @interno.estado + ', ' + @interno.codigo_postal}",
				  size: 8, at: [100,490]
		draw_text "Teléfono(s):", size: 8, style: :bold, at: [0,475]
		draw_text "#{ @interno.telefono_fijo.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3') + ', ' + 
					  @interno.telefono_celular.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3') + ', ' + 
					  @interno.telefono_otro.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3')}",
		          	  size: 8, at: [60, 475]				  
		draw_text "Diágnostico de ingreso:", size: 8, style: :bold, at: [0,460]          	  
        text_box "#{@interno.ingresos.last.descripcion_estado_salud}", size: 8, width: 545, at: [0, 450], align: :justify
        draw_text "Motivos de salida", size: 8, style: :bold, at: [0,410]
        draw_text "Solicitud del Usuario", size: 8,  at: [20,390]
        text_si_no(@interno.egresos.last.usuario, 480,390)
        draw_text "Solicitud de un familiar", size: 8,  at: [20,370]
        text_si_no(@interno.egresos.last.familiar, 480,370)
        draw_text "Trataminento concluido", size: 8,  at: [20,350]
        text_si_no(@interno.egresos.last.concluido, 480,350)
        draw_text "Disposición de alguna autoridad legal competente", size: 8,  at: [20,330]
        text_si_no(@interno.egresos.last.autoridad, 480,330)
        draw_text "Referencia", size: 8,  at: [20,310]
        text_si_no(@interno.egresos.last.referencia, 480,310)
        draw_text "Abandonó las instalaciones sin consentimiento del responsable del tratamiento", size: 8,  at: [20,290]
        text_si_no(@interno.egresos.last.abandono, 480,290)
                draw_text "Defunción", size: 8,  at: [20,270]
        text_si_no(@interno.egresos.last.defuncion, 480,270)
        
        i = 230
        draw_text "Tratamientos llevados a cabo:", size: 8, style: :bold, at: [0,250]
        @interno.tratamientos.each do |tratamiento|
        	draw_text tratamiento.nombre_tratamiento, size:8, at: [20, i]
        	i = i -15
        end 

        stroke do
			stroke_color '020202'
    		self.line_width = 1
		end
        stroke_line [0, 60], [150, 60]
  			draw_text "Firma y Fecha", size: 8, at: [20,45]
  			draw_text "Responsable del Usuario", size: 8, at: [20,30]
  			 
  			stroke_line [300, 60], [450,60]	
  			draw_text "Firma y Fecha", size: 8, at: [310,45]	
  			draw_text "Responsable del Establecimiento", size: 8, at: [310,30]	

	end
end
