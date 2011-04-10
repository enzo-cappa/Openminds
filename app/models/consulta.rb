# == Schema Information
# Schema version: 19
#
# Table name: consultas
#
#  id            :integer(4)      not null, primary key
#  fecha         :date            default(Mon, 04 Apr 2011), not null
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
        #scopes
        named_scope :visible, :conditions => ["hidden != ?", true]
        before_create :agregar_fecha

	def cambiaEstado(user)
		if user.privilegio == 4 || 7 
			self.estado_id = Estado.find_by_estado("En espera").id
		else
			self.estado_id = Estado.find_by_estado("Pendiente").id
		end
		self.save!
	end
        
        #para ver informacion sobre la gema para hacer filtros ver 
        #http://metautonomo.us/projects/metawhere/
           
        #devuelve un filtro de consultas
        def self.filtro(usuario_id,titulo,estado,fecha_inicio,fecha_final,orden=:fecha)
           fecha_inicio="2011-01-01" if fecha_inicio.blank?
           fecha_final=Date.today if fecha_final.blank?
           relacion=Consulta.where(:usuario_id >> usuario_id,:estado_id >> estado, :titulo =~ "%#{titulo}%",:fecha >= fecha_inicio, :fecha <=fecha_final)
           relacion.order(orden)
        end
        def self.filtro_operador(titulo,estado,fecha_inicio,fecha_final,categoria,aplicacion,orden=:fecha)
           fecha_inicio="2011-01-01" if fecha_inicio.blank?
           fecha_final=Date.today if fecha_final.blank?
           relacion=Consulta.where(:estado_id >> 1,:estado_id >> estado,:titulo =~ "%#{titulo}%",:fecha >= fecha_inicio, :fecha <= fecha_final,:categoria_id >> categoria,:aplicacion_id >> aplicacion)
           relacion.order(orden)
        end

private
    def agregar_fecha
      self.fecha=Date.today
    end

end
