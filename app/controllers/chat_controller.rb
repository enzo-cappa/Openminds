class ChatController < ApplicationController
	def new
		@chat = Chat.new
		@categoria = Categoria.all
		@app = Aplicacion.all
	end

	def create
		@chat = Chat.new(:titulo => params[:chat][:titulo],
		:usuario_id => session[:usuario][:id],
		:aplicacion_id => params[:chat][:aplicacion_id],
		:categoria_id => params[:chat][:categoria_id],
		:estado_id => Estado.find_by_estado("Pendiente").id)
		if @chat.save
			redirect_to :action => 'init'
		else
			render :action => "new"
		end
	end

	def init
	end

	def enviar_mensaje
		chat = Chat.find(params[:chat][:id])
		if (chat.operador != null and (chat.usuario.id == session[:usuario][:id] or chat.operador.id == session[:usuario][:id]))
			@mensaje = Mensaje.new(:chat_id => chat.id, :texto => params[:mensaje][:texto], 
			:asunto => 'chat', :fechaHora => Time.now, :usuario_id => session[:usuario][:id])
			if @mensaje.save
				#devolver ok
			end			
		else
			redirect_to :action => 'new'
		end
	end

	def get_mensajes
		chat = Chat.find(params[:chat][:id])

		if (chat.operador != null and (chat.usuario.id == session[:usuario][:id] or chat.operador.id == session[:usuario][:id]))
			@mensajes = Mensaje.mas_nuevo_que params[:timestamp]
			respond_to do |format|
				format.xml { render :xml => @mensajes }
			end
		else
			redirect_to :action => 'new'
		end
	end

	def list_pendiente
		@chats = Chat.pendientes.paginate :page => params[:page], :per_page => 20
	end

	def tomar
		@chat = Chat.find(params[:id])
		@chat.operador_id = session[:usuario][:id]
		@chat.estado_id = Estado.find_by_estado("En espera").id
		if @chat.save
			render :action => 'init'
		end
	end
end
