class Mensaje < ActiveRecord::Base
	has_one :imagen
	belongs_to :usuario
	belongs_to :consulta
end
