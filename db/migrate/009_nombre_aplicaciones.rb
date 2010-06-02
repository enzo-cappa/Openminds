class NombreAplicaciones < ActiveRecord::Migration
  def self.up
	
	aplicacion = Aplicacion.new(:nombre => "Writer")
	aplicacion.save!
	
	aplicacion = Aplicacion.new(:nombre=>"Calc")
	aplicacion.save!
	
	aplicacion = Aplicacion.new(:nombre=>"Base")
	aplicacion.save!

	aplicacion = Aplicacion.new(:nombre=>"Draw")
	aplicacion.save!

	aplicacion = Aplicacion.new(:nombre=>"Impress")
	aplicacion.save!

	aplicacion = Aplicacion.new(:nombre=>"Math")
	aplicacion.save!
	
  end

  def self.down
	end
end
