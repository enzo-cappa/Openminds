class Info < ActiveRecord::Base
	def adjunto=(incoming_file)
    self.archivo = incoming_file.original_filename
		self.tipo = incoming_file.content_type.chomp
    self.datos_binarios = incoming_file.read
  end
end
