class IngresosController < ApplicationController
    before_action :set_interno, only: [:show, :edit, :update, :destroy]
    before_action :set_ingreso, only: [:show, :edit, :update, :destroy]
   
 def show
end

def edit
end
   
def create
    @interno = Interno.find(params[:interno_id])
    @ingreso = @interno.ingresos.create(ingreso_params)
    redirect_to interno_path(@interno)
    @ingreso = Ingreso.new(ingreso_params)     
end
   
def update
    respond_to do |format|
      if @ingreso.update(ingreso_params)
        format.html { redirect_to @interno, notice: 'Registro actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @ingreso }
         
      else
        format.html { render :edit }
        format.json { render json: @ingreso.errors, status: :unprocessable_entity }
      end
    end
  end

   
  def destroy
    @ingreso.destroy
    respond_to do |format|
      format.html { redirect_to @interno, notice: 'Registro eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def set_interno
      @interno = Interno.find(params[:interno_id])
    end

    def set_ingreso
      @ingreso = @interno.ingresos.find(params[:id])
    end

     
    def ingreso_params
      params.require(:ingreso).permit(:fecha_hora,:referido_institucion,:institucion_referencia,:hoja_referencia,
                                      :tipo_ingreso,:motivo_ingreso,:descripcion_estado_salud,:hombre,:mayor_edad,:dependencias,
                                      :consecuencias,:transtorno_mental,:cumple,:referirlo,:nombre_entrevistador,:cargo_entrevistador)
    end
 
end



