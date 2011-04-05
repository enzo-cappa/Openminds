# == Schema Information
# Schema version: 19
#
# Table name: mensajes
#
#  id          :integer(4)      not null, primary key
#  fechaHora   :datetime        default(Mon Apr 04 00:00:00 UTC 2011), not null
#  texto       :text(255)       default(""), not null
#  usuario_id  :integer(4)      not null
#  asunto      :string(40)      default(""), not null
#  consulta_id :integer(4)      not null
#

class Mensaje < ActiveRecord::Base
	has_one :imagen
	belongs_to :usuario
	belongs_to :consulta
end
