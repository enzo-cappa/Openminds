class AgregarHerenciaAConsulta < ActiveRecord::Migration
  def self.up
		add_column :consultas, :type, :string
  end

  def self.down
		remove_column :consultas, :type
  end
end
