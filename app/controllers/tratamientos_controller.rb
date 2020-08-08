class TratamientosController < ApplicationController
    before_action :set_interno, only: [:show, :edit, :update, :destroy]
    before_action :set_tratamiento, only: [:show, :edit, :update, :destroy]
   
 def show
   render_404
end

def render_404
  respond_to do |format|
    format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    format.xml  { head :not_found }
    format.any  { head :not_found }
  end
end

def edit
end
   
def create
    @interno = Interno.find(params[:interno_id])
    @tratamiento = @interno.tratamientos.create(tratamiento_params)
    redirect_to interno_path(@interno)
    @tratamiento = Tratamiento.new(tratamiento_params)     
end
   
def update
    respond_to do |format|
      if @tratamiento.update(tratamiento_params)
        format.html { redirect_to @interno, notice: 'Registro actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @tratamiento }
      else
        format.html { render :edit }
        format.json { render json: @tratamiento.errors, status: :unprocessable_entity }
      end
    end
  end
   
  def destroy
    @tratamiento.destroy
    respond_to do |format|
      format.html { redirect_to @interno, notice: 'Registro eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def set_interno
      @interno = Interno.find(params[:interno_id])
    end

    def set_tratamiento
      @tratamiento = @interno.tratamientos.find(params[:id])
    end

     
    def tratamiento_params
      params.require(:tratamiento).permit(:fecha_inicio, :fecha_fin, :total_horas, :observaciones, :nombre_tratamiento)
    end
 
end





