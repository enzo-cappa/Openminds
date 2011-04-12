class SacaFechaNacimientoDeUsuario < ActiveRecord::Migration
  def self.up
     remove_column :usuarios, :fechaNac
  end

  def self.down
      add_column :usuarios,:fechaNac, :date, :null=>false
  end
end
