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
    condiciones = 'usuario_id = ' + session[:usuario][:id].to_s
    @estado = Estado.all
    if !params[:orden]
      orden='fecha'
    else
      orden=params[:orden][:select]
    end

    if params[:mostrar]
      est = Estado.find_by_estado(params[:mostrar][:mostrarEstado])
      condiciones = condiciones + ' AND estado_id = ' + est.id.to_s
    else
      if params[:filtros]
        if params[:filtros][:mostrarEstado]
          est = Estado.find_by_estado(params[:filtros][:mostrarEstado])
          condiciones = condiciones + ' AND estado_id = ' + est.id.to_s
        end
        if params[:filtros][:titulo] && params[:filtros][:titulo] != ''
          condiciones = condiciones + ' AND titulo LIKE #' + params[:filtros][:titulo] + '#'
        end
        if params[:filtros][:fechaDesde] != '' && params[:filtros][:fechaHasta] != ''
          condiciones = condiciones + " AND fecha BETWEEN '" + params[:filtros][:fechaDesde] + "' AND '" + params[:filtros][:fechaHasta] + "'"
        end
      end
    end

    @consultas = Consulta.paginate :page => params[:page], :order => orden, :conditions => condiciones
    render :action=>'list'
  end

  def list_tuto
    @titulo = "Todas las consultas"
    condiciones = ''
    @estado = Estado.all
    if !params[:orden]
      orden='fecha'
    else
      orden=params[:orden][:select]
    end
    if params[:mostrar]
      est = Estado.find_by_estado(params[:mostrar][:mostrarEstado])
      condiciones = condiciones + ' AND estado_id = ' + est.id.to_s
    else
      if params[:filtros]
        if params[:filtros][:mostrarEstado]
          est = Estado.find_by_estado(params[:filtros][:mostrarEstado])
          condiciones = condiciones + ' AND estado_id = ' + est.id.to_s
        end
        if params[:filtros][:titulo] && params[:filtros][:titulo] != ''
          condiciones = condiciones + ' AND titulo LIKE #' + params[:filtros][:titulo] + '#'
        end
        if params[:filtros][:fechaDesde] != '' && params[:filtros][:fechaHasta] != ''
          condiciones = condiciones + " AND fecha BETWEEN '" + params[:filtros][:fechaDesde] + "' AND '" + params[:filtros][:fechaHasta] + "'"
        end
      end
    end
    if condiciones != ''
      @consultas = Consulta.paginate :page => params[:page], :order => orden, :conditions => condiciones
    else
      @consultas = Consulta.paginate :page => params[:page], :order => orden
    end
    render :action => 'list'
	end
  
	def list_op
    @categorias = Categoria.all
    @aplicaciones = Aplicacion.all
    @estado = Estado.find_by_estado("Pendiente")
    condiciones = "estado_id = " + @estado.id.to_s
    if params[:mostrar]
      if params[:mostrar][:categoria]
        condiciones = condiciones + ' AND  categoria_id LIKE ' + params[:mostrar][:categoria]
      end
      if params[:mostrar][:aplicacion]
        condiciones = condiciones + ' AND  aplicacion_id LIKE ' + params[:mostrar][:aplicacion]
      end
    end
    if params[:filtros]
      if params[:filtros][:titulo] && params[:filtros][:titulo] != ''
        condiciones = condiciones + ' AND titulo LIKE #' + params[:filtros][:titulo] + '#'
      end
      if params[:filtros][:fechaDesde] != '' && params[:filtros][:fechaHasta] != ''
        condiciones = condiciones + " AND fecha BETWEEN '" + params[:filtros][:fechaDesde] + "' AND '" + params[:filtros][:fechaHasta] + "'"
      end
    end
    @consultas = Consulta.paginate :page => params[:page], :order => 'fecha DESC', :conditions => condiciones
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

  protected

  def permiso_requerido(accion)
    #Todas requieren nivel de acceso 1
    1
  end
end
