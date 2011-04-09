class ApplicationController < ActionController::Base

  layout "global"
  protect_from_forgery
  before_filter :autorizar, :except => [ :login, :logout ]

  protected

  def autorizar
    #validacion de que este logueado el usuario y que no sea la registracion de usuario, se excluye del beforefilter ya que no se puede expecificar el controlador en el filter
    if env["REQUEST_URI"] != '/usuarios/new' && env["REQUEST_URI"] != "/usuarios/create"
      if session[:usuario]
        #validacion del nivel de acceso
        permiso_requerido = permiso_requerido(action_name)
        permiso_requerido ||= 7
        if session[:usuario].privilegio.to_i < permiso_requerido
          session[:usuario] = nil
          flash[:notice] = "No posee permisos para realizar tal accion"
          redirect_to :controller => 'admin' , :action => 'login'
        end
      else
        flash[:notice] = "Por favor ingrese sus datos de usuario"
        redirect_to :controller => 'admin' , :action => 'login'
      end
    end
  end

  def permiso_requerido(accion)
  end
  
end
