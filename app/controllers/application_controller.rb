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
  @@permisos={}
  @@permisos["mensajes"]={'create' => 1, 'new' =>1, 'get_imagen' => 1}
  @@permisos["chat"]={"newMensaje"=>1, "newMensaje"=>1,"enviar"=>1, "list"=>1,"new"=>1 }
  @@permisos["consultas"]={"mis_consu_list"=>1,"list_tuto"=>4,"list_op"=>4,"list_op"=>4,"new"=>1,"show"=>1,"create"=>1,"finalizar"=>1}
  @@permisos["help_desk"]={"index"=>1}
  @@permisos["infos"]={"index"=>1,"list"=>1,"new"=>1,"create"=>1,"edit"=>1,"update"=>1,"destroy"=>1, "get_archivo"=>1}
  @@permisos["usuarios"]={'index' => 1, 'list' => 3, 'list_order' => 0, 'list_search' => 4, 'show' => 1, 'new' => 0, 'create' => 0,
                'edit' => 0, 'update' => 0, 'destroy' => 7, 'acept' => 4, 'admitir' => 4, "mostrar_historial"=>7}
  @@permisos[controller_name][action_name]
  end
  
end
