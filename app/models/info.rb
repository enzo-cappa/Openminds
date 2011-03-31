# == Schema Information
# Schema version: 19
#
# Table name: infos
#
#  id             :integer(4)      not null, primary key
#  nombre         :string(30)      not null
#  desc           :string(100)     not null
#  archivo        :string(30)      not null
#  datos_binarios :binary          default(""), not null
#  tipo           :string(255)     not null
#

class Info < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

	def adjunto=(incoming_file)
    self.archivo = incoming_file.original_filename
		self.tipo = incoming_file.content_type.chomp
    self.datos_binarios = incoming_file.read
  end
end
