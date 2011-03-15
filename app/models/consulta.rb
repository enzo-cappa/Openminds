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
