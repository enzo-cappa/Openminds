class MensajeDeChat < ActiveRecord::Base
	has_one :image
	belongs_to :usuario
	belongs_to :chat
end
