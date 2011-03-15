class Info < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

	def adjunto=(incoming_file)
    self.archivo = incoming_file.original_filename
		self.tipo = incoming_file.content_type.chomp
    self.datos_binarios = incoming_file.read
  end
end
