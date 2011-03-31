class ApplicationController < ActionController::Base

  layout "global"
  protect_from_forgery
  before_filter :autorizar, :except => [ :login, :logout ]

  protected

  def autorizar
    #validacion de que este logueado el usuario
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

  def permiso_requerido(accion)
  end
  
end
