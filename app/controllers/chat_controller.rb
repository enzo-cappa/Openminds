class ChatController < ApplicationController
	def new
		@chat = Chat.new
	end
	def newMensaje
		@chat
	end
	def enviar
		render_text 
	end
	def list
	end
end
