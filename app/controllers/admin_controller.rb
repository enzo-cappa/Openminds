class AdminController < ApplicationController

  def login
    if request.post?
      user = Usuario.autenticar(params[:nombre], params[:contrasenia])
      if user
        session[:usuario] = user
      else
        flash[:warning] = "Usuario o password incorrectos, por favor ingrese nuevamente su usuario y password"
      end      
    end
    redirect_to(:controller => :help_desk , :action => "index")
  end

  def logout
    session[:usuario] = nil
    flash[:notice] = "Se cerro la sesion correctamente"
    redirect_to(:controller => :help_desk , :action => "index")
  end
end
