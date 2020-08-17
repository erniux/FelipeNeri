class PaginasController < ApplicationController

	def inicio
	end

	def ingreso
		@interno = Interno.find(params[:id])
		respond_to do |format|
      		format.html
      		format.pdf do
              pdf = IngresoPdf.new(@interno)
        		 send_data pdf.render, filename: "ingreso_#{@interno.ingresos.last.id}.pdf",
                                   type: "application/pdf",
                                   disposition: "inline" 
      		end
    	end
    end

  def egreso
    @interno = Interno.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EgresoPdf.new(@interno)
        send_data pdf.render, fiilename: "egreso_#{@interno.egresos.last.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
    
end
