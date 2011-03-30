# == Schema Information
# Schema version: 19
#
# Table name: consultas
#
#  id            :integer(4)      not null, primary key
#  fecha         :date            default(Tue, 29 Mar 2011), not null
#  estado_id     :integer(4)      not null
#  titulo        :string(25)      default(""), not null
#  usuario_id    :integer(4)      not null
#  aplicacion_id :integer(4)      not null
#  categoria_id  :integer(4)      not null
#

class Consulta < ActiveRecord::Base
	belongs_to :usuario
	has_many :mensajes
	belongs_to :estado
  cattr_reader :per_page
  @@per_page = 10

	def cambiaEstado(user)
		if user.privilegio == 4 || 7 
			self.estado_id = Estado.find_by_estado("En espera").id
		else
			self.estado_id = Estado.find_by_estado("Pendiente").id
		end
		self.save!
	end
end
