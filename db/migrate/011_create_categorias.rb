class CreateCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias do |t|
		t.column :categoria, :string,:null=>false,:limit=>25, :default=>''
    end
  end

  def self.down
    drop_table :categorias
  end
end
