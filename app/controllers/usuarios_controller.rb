class UsuariosController < ApplicationController

  @@permisos = {'index' => 0, 'list' => 3, 'list_order' => 0, 'list_search' => 7, 'show' => 1, 'new' => 0, 'create' => 0,
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
  end
  
  def list_order
    @usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :order =>params[:filtros][:select]
    render :action=>"list"
  end

  def list_search
    @usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :conditions => [params[:busqueda][:select]+' = ?', params[:busqueda][:text] ] ,:order =>params[:busqueda][:select]
    render :action=>"list"
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      flash[:notice] = 'Su usuario ha sido dado de alta en el sistema, gracias por elegir nuestros servicios.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
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
  end

  def admitir
    @usuario=Usuario.find(params[:id])
    @usuario.admitir
    redirect_to :action=>'acept'
  end

  protected

  def permiso_requerido(accion)
    @@permisos[accion]
  end
end
