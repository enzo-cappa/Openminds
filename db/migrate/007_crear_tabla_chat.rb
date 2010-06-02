class CrearTablaChat < ActiveRecord::Migration
  def self.up
	create_table :chats do |t|
		t.column :fechaHoraInicio, :datetime, :null=>false
		t.column :ultMensaje, :time, :null=>false
	end
  end

  def self.down
	end
end
