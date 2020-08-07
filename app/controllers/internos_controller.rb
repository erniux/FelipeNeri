class InternosController < ApplicationController
    before_action :set_interno, only: [:show, :edit, :update, :destroy]
   
def index     
    @internos = Interno.all
    
end

def show
end

def new
    @interno = Interno.new
end

def edit
end
   
def create
    @interno = Interno.new(interno_params)

    respond_to do |format|
      if @interno.save
        format.html { redirect_to interno_path, notice: 'Registro creado con éxito.' }
          
      else
        format.html { render :new }
      end
    end
end
   
def update
    respond_to do |format|
      if @interno.update(interno_params)
        format.html { redirect_to interno_path, notice: 'Registro actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @interno }
      else
        format.html { render :edit }
        format.json { render json: @interno.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interno.destroy
    respond_to do |format|
      format.html { redirect_to internos_path, notice: 'Registro eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def set_interno
      @interno = Interno.find(params[:id])
    end

     
    def interno_params
      params.require(:interno).permit(:nombre, :ap_paterno, :ap_materno, :fecha_nacimiento, :calle, :numero, :interior, 
                                      :colonia, :municipio, :estado, :telefono_fijo, :telefono_celular, :telefono_otro, 
                                      :nacionalidad, :estado_civil, :escolaridad, :ocupacion)
    end
 
end


 