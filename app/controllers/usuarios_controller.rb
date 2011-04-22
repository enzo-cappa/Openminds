class UsuariosController < ApplicationController

  @@permisos = {'index' => 0, 'list' => 3, 'list_order' => 0, 'list_search' => 4, 'show' => 1, 'new' => 0, 'create' => 0,
                'edit' => 0, 'update' => 0, 'destroy' => 7, 'acept' => 4, 'admitir' => 4}

  helper :date
  
  def index
    redirect_to :action => 'list'
  end


  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def list
    @usuarios = Usuario.paginate :page => params[:page], :order => "nombre"
    render :list
  end
  
  def list_order
    @usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :order =>params[:filtros][:select]
    render :action=>"list"
  end

  def list_search
    #si viene del list tiene que realizar una busqueda de usuarios con privilegios menores o iguales a 7 si no solo de los 0
    if (env["HTTP_REFERER"].include? "/usuarios/list") && (session[:usuario][:privilegio].to_i >= 7) 
      @usuarios=Usuario.filtro(params[:busqueda][:criterio],params[:busqueda][:clave],params[:busqueda][:orden],7) 
    else
      @usuarios=Usuario.filtro(params[:busqueda][:criterio],params[:busqueda][:clave],params[:busqueda][:orden])
    end
    render :list
  end

  def show
    if (session[:usuario][:id]==params[:id].to_i ) || (session[:usuario][:privilegio].to_i==7)
      @usuario = Usuario.find(params[:id])
    else
      redirect_to "/"
    end
    
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
       flash[:notice] = 'Su usuario ha sido dado de alta en el sistema, gracias por elegir nuestros servicios. Un operador estara dando de alta a su usuario en breve'
       render '/help_desk/index.rhtml'
    else
      render :action => 'new'
    end
  end

  def edit
    if (session[:usuario][:id]==params[:id].to_i ) || (session[:usuario][:privilegio].to_i==7)
      @usuario = Usuario.find(params[:id])
    else
      redirect_to "/"
    end
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(params[:usuario])
      flash[:notice] = 'Su usuario ha sido modificado satisfactoriamente.'
      redirect_to :action => 'show', :id => @usuario
    else
      render :action => 'edit'
    end
  end

  def destroy
    Usuario.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def acept
    
    @usuarios = Usuario.paginate :page => params[:page], :order => "privilegio", :conditions => ['privilegio < 1']
    render :list
  end

  def admitir
    @usuario=Usuario.find(params[:id])
    @usuario.admitir(session[:usuario][:id])
    
    redirect_to :action=>'acept'
  end
  def mostrar_historial
    @log=Usuario.mostrar_historial
  end

  protected
end
