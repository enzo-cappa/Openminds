class ConsultasController < ApplicationController
  helper :date 
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def mis_consu_list
    @titulo = "Mis consultas"
    @estado = Estado.all
    if !params[:filtros]
      @consultas = Consulta.find_all_by_usuario_id(session[:usuario][:id]).paginate :page => params[:page] 
    else
      @consultas=Consulta.filtro(session[:usuario].id,params[:filtros][:titulo],params[:filtros][:estado],params[:filtros][:fechaDesde],params[:filtros][:fechaHasta],params[:orden][:select])
    end
    render 'list'
  end

  def list_tuto
    @titulo = "Todas las consultas"
    @estado = Estado.all
    @aplicaciones = Aplicacion.all
    @categorias=Categoria.all 
    if !params[:filtros]
      @consultas = Consulta.all.paginate :page => params[:page]
    else
      @consultas=Consulta.filtro_operador(params[:filtros][:estado],params[:filtros][:titulo],params[:filtros][:fechaDesde],params[:filtros][:fechaHasta],params[:filtros][:categoria],params[:filtros][:aplicacion],params[:filtros][:orden]).paginate :page=>params[:page] 
    end
    render  'list_op'
	end
  
  def list_op
    @categorias = Categoria.all
    @aplicaciones = Aplicacion.all
    @estado = Estado.all
    
    #si tiene el parametro filtros es porque viene del formulario de filtros, sino es la primera vez que entra a la pagina o un refresh
    if !params[:filtros] 
      @consultas = Consulta.find_all_by_estado_id(1).paginate
    else
      @consultas=Consulta.filtro_operador(1,params[:filtros][:titulo],params[:filtros][:fechaDesde],params[:filtros][:fechaHasta],params[:filtros][:categoria],params[:filtros][:aplicacion],params[:filtros][:orden]).paginate :page=>params[:page]
    end
  end
  
  def show
    @consulta = Consulta.find(params[:id])
  end

  def new
    @consulta = Consulta.new
    @categoria = Categoria.all
    @app = Aplicacion.all
  end

  def create
    @consulta = Consulta.new(	:titulo => params[:consulta][:titulo],
      :usuario_id => session[:usuario][:id],
      :aplicacion_id => params[:consulta][:aplicacion_id],
      :categoria_id => params[:consulta][:categoria_id],
      :estado_id => Estado.find_by_estado("Pendiente").id)
    @consulta.save

    @mensaje = Mensaje.new( :asunto => params[:consulta][:titulo],
      :texto => params[:mensaje][:texto],
      :usuario_id => session[:usuario][:id],
      :consulta_id => @consulta.id)
    @mensaje.save

    unless params[:image_file].blank?
      @imagen = Imagen.new(:mensaje_id => @mensaje.id)
      @imagen.image_file = params['image_file']
      @imagen.save
    end

    if  @mensaje
      flash[:notice] = 'Se registro la consulta'
      redirect_to :action => 'show', :id => @consulta
    else
      @consulta.destroy
      redirect_to :action => 'list'
    end
  end
  
 	def finalizar
		@consulta= Consulta.find_by_id(params[:id])
		@consulta.estado = Estado.find_by_estado('Finalizada')
		@consulta.save
		redirect_to :back
	end
end
