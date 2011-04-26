# == Schema Information
# Schema version: 20110422180905
#
# Table name: consultas
#
#  id            :integer(4)      not null, primary key
#  fecha         :date            default(Fri, 22 Apr 2011), not null
#  estado_id     :integer(4)      not null
#  titulo        :string(25)      default(""), not null
#  usuario_id    :integer(4)      not null
#  aplicacion_id :integer(4)      not null
#  categoria_id  :integer(4)      not null
#  operador_id   :integer(4)
#

class Chat < AbstractConsulta
	
	def self.pendientes
		Chat.where(:estado_id=>Estado.find_by_estado("Pendiente").id)
	end
end
