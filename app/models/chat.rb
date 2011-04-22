# == Schema Information
# Schema version: 19
#
# Table name: chats
#
#  id              :integer(4)      not null, primary key
#  fechaHoraInicio :datetime        not null
#  ultMensaje      :time            not null
#

class Chat < Consulta
	
	def self.pendientes
		Chat.where(:estado_id=>Estado.find_by_estado("Pendiente").id)
	end
end
