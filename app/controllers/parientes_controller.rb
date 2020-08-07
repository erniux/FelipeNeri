class ParientesController < ApplicationController
    before_action :set_interno, only: [:show, :edit, :update, :destroy]
    before_action :set_pariente, only: [:show, :edit, :update, :destroy]
   
 def show
end

def edit
end
   
def create
    @interno = Interno.find(params[:interno_id])
    @pariente = @interno.parientes.create(pariente_params)
    redirect_to interno_path(@interno)
    @pariente = Pariente.new(pariente_params)     
end
   
def update
    respond_to do |format|
      if @pariente.update(pariente_params)
        format.html { redirect_to @interno, notice: 'Registro actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @pariente }
      else
        format.html { render :edit }
        format.json { render json: @pariente.errors, status: :unprocessable_entity }
      end
    end
  end
   
  def destroy
    @pariente.destroy
    respond_to do |format|
      format.html { redirect_to @interno, notice: 'Registro eliminado con éxito.' }
      format.json { head :no_content }
    end
  end
  
  private
    def set_interno
      @interno = Interno.find(params[:interno_id])
    end

    def set_pariente
      @pariente = @interno.parientes.find(params[:id])
    end

     
    def pariente_params
      params.require(:pariente).permit(:nombre, :ap_paterno, :ap_materno, :fecha_nacimiento, :ocupacion, :parentesco, :calle, :numero, 
                                       :interior, :colonia, :municipio, :estado, :telefono_fijo, :telefono_celular, :telefono_recados)
    end
 
end



