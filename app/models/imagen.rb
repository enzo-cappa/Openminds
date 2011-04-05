# == Schema Information
# Schema version: 19
#
# Table name: imagenes
#
#  id             :integer(4)      not null, primary key
#  content_type   :string(255)     not null
#  archivo        :string(255)     not null
#  datos_binarios :binary          default(""), not null
#  mensaje_id     :integer(4)
#

class Imagen < ActiveRecord::Base
	belongs_to :mensaje
	belongs_to :mensajedechat,
						 :foreign_key => 'mensaje_id'
  def image_file=(incoming_file)
    self.archivo = incoming_file.original_filename
    self.content_type = incoming_file.content_type.chomp
    self.datos_binarios = incoming_file.read
  end
end
