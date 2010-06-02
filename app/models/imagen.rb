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
