class CreateCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias do |t|
      t.column :categoria, :string, :null=>false, :limit=>25, :default=>''
    end
    Categoria.create(:categoria=>"Soporte Técnico")
		Categoria.create(:categoria=>"Informe Administrativo")
		Categoria.create(:categoria=>"Otros")
  end

  def self.down
    drop_table :categoria
  end
end
