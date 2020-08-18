class EgresosController < ApplicationController
    before_action :set_interno, only: [:show, :edit, :update, :destroy]
    before_action :set_egreso, only: [:show, :edit, :update, :destroy]
   
 def show
end

def edit
end
   
def create
    @interno = Interno.find(params[:interno_id])
    @egreso = @interno.egresos.create(egreso_params)
    redirect_to interno_path(@interno)
    @egreso = Egreso.new(egreso_params)     
end
   
def update
    respond_to do |format|
      if @egreso.update(egreso_params)
        format.html { redirect_to @interno, notice: 'Registro actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @egreso }
      else
        format.html { render :edit }
        format.json { render json: @egreso.errors, status: :unprocessable_entity }
      end
    end
  end
   
  def destroy
    @egreso.destroy
    respond_to do |format|
      format.html { redirect_to @interno, notice: 'Registro eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def set_interno
      @interno = Interno.find(params[:interno_id])
    end

    def set_egreso
      @egreso = @interno.egresos.find(params[:id])
    end

     
    def egreso_params
      params.require(:egreso).permit(:diagnostico_egreso, :observaciones_egreso, :fecha_egreso,:usuario, :familiar, :concluido, 
                                     :autoridad, :referencia, :abandono, :defuncion, :documento)
    end
 
end
 





