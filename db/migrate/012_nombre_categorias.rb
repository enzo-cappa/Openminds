class NombreCategorias < ActiveRecord::Migration
  def self.up
		categoria = Categoria.new(:categoria=>"Soporte T�cnico")
		categoria.save!

		categoria = Categoria.new(:categoria=>"Informe Administrativo")
		categoria.save!

		categoria = Categoria.new(:categoria=>"Otros")
		categoria.save!
  end

  def self.down
  end
end
