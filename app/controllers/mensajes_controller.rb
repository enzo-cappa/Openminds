class MensajesController < ApplicationController
	# GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
	verify :method => :post, :only => [ :destroy, :create, :update ], :redirect_to => {:controller => 'consulta'}
	def new
		@mensaje = Mensaje.new
		@mensaje.consulta_id = params[:id]
	end

	def create
		@mensaje = Mensaje.new( :asunto => params[:mensaje][:asunto],
		:texto => params[:mensaje][:texto],
		:usuario_id => session[:usuario][:id],
		:consulta_id => params[:mensaje][:consulta_id])
		if params[:image_file] != ""
			@imagen = Imagen.new(:mensaje_id => @mensaje.id)

			@imagen.image_file =  params['image_file']
		@imagen.save
		end
		if @mensaje.save
			@mensaje.consulta.cambiaEstado(@mensaje.usuario)
			flash[:notice] = 'Se registro el mensaje'
			redirect_to :controller => 'consultas', :action=> 'show', :id => @mensaje.consulta_id
		else
			redirect_to :controller => 'consulta'
		end
	end

	def get_imagen
		mensaje = Mensaje.find(params[:id])
		@image_data = mensaje.imagen
		@imagen = @image_data.datos_binarios
		send_data(@imagen,:type     => @image_data.content_type,
                       :filename => @image_data.archivo,
                       :disposition => 'inline')
	end
end
