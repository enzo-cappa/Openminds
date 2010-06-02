class CreateMensajes < ActiveRecord::Migration
  def self.up
    create_table :mensajes do |t|
			t.column :fechaHora, :datetime, :null=>false, :default => Time.now.to_date
			t.column :texto, :text,:null=>false,:limit=>20, :default=>''
			t.column :usuario_id, :integer, :null=>false
			t.column :asunto, :string,:null=>false,:limit=>40, :default=>''
			t.column :consulta_id, :integer, :null=>false
		end
	end

  def self.down
    drop_table :mensajes
  end
end
