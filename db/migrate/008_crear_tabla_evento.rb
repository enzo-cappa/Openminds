class CrearTablaEvento < ActiveRecord::Migration
  def self.up
	create_table :eventos do |t|
		t.column :fechaHora, :time,:null=>false
		t.column :desc, :string,:null=>false,:limit=>50, :default=>''
	end
  end

  def self.down
  end
end
