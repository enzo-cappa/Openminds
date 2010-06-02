class CrearTablaConsultas < ActiveRecord::Migration
  def self.up
		create_table :consultas do |t|
	     #el id lo agrega solo
			t.column :fecha, :date, :null=>false, :default => Time.now.to_date
			t.column :estado_id, :integer,:null=>false
			t.column :titulo, :string,:null=>false,:limit=>25, :default=>''
			t.column :usuario_id, :integer, :null=>false
			t.column :aplicacion_id, :integer, :null=>false
			t.column :categoria_id, :integer, :null=>false
    end

  end

  def self.down
	drop_table :consultas
  end
end
