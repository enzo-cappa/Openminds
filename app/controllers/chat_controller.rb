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

	def enviar
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
