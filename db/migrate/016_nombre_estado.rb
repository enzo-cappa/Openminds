class NombreEstado < ActiveRecord::Migration
  def self.up
		estado = Estado.new(:estado => "Pendiente")
		estado.save!

		estado = Estado.new(:estado => "En espera")
		estado.save!

		estado = Estado.new(:estado => "Finalizada")
		estado.save!
  end

  def self.down
  end
end
