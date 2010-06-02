class UsuariosController < ApplicationController
	helper :date
  def verificaSession(privilegio)
  	if(session[:usuario]==nil)
		redirect_to "http://"+request.host_with_port()	
	else 
		if (session[:usuario].privilegio.to_i < privilegio)
			session[:usuario]=nil
			redirect_to "http://"+request.host_with_port()
		else
			yield
		end
	end
  end
  def index
  	verificaSession(0){
		redirect_to :action => 'list'
	}
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
  	verificaSession(3){
	#@usuario_pages, @usuarios = paginate :usuarios, :per_page => 10
        @usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :order => "nombre"
  	}
  end  
  def listOrder
	@usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :order =>params[:filtros][:select]
	render :action=>"list"
  end

  def listSearch
  	verificaSession(7){
        @usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :conditions => [params[:busqueda][:select]+' = ?', params[:busqueda][:text] ] ,:order =>params[:busqueda][:select]
	render :action=>"list"
	}
  end

  def show
    verificaSession(1){
    	@usuario = Usuario.find(params[:id])
    }
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
    if(params[:id].to_i != session[:usuario].id.to_i) 
    	if (7 > session[:usuario].privilegio.to_i   )
    	session[:usuario]=nil
    	end
    end
    verificaSession(1){
    	@usuario = Usuario.find(params[:id])
    }
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
    verificaSession(7){
        Usuario.find(params[:id]).destroy
    	redirect_to :action => 'list'
    }
  end
  def bienvenida

	@usr=Usuario.find(:first, :conditions =>["nomUsuario="+"'"+params[:us][:nomUsuario]+"'"+" and " "contrasenia="+"'"+params[:us][:contrasenia]+"'"])
	if @usr==nil
		flash[:warning]="Usuario o password incorrectos, por favor ingrese nuevamente su usuario y password"
		session[:usuario]=nil
		#redirect_to "http://"+request.host_with_port()  
	else 
	   session[:usuario]=@usr
	end
  end
  def acept
  	verificaSession(4){
  	@usuario_pages, @usuarios = paginate :usuarios, :per_page => 10, :order => "privilegio", :conditions => ['privilegio < 1'] 
  	}
  end
  def admitir
  	verificaSession(4){
	@usuario=Usuario.find(params[:id])
	@usuario.admitir
	redirect_to :action=>'acept'
  }
  end
  def logout
  	session[:usuario]=nil
	redirect_to "http://"+request.host_with_port()  
  end
  
end
