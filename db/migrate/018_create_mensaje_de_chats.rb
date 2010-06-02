class CreateMensajeDeChats < ActiveRecord::Migration
  def self.up
    create_table :mensaje_de_chats do |t|
			t.column :fechaHora, :datetime, :null=>false, :default => Time.now.to_date
			t.column :texto, :text,:null=>false,:limit=>20, :default=>''
			t.column :usuario_id, :integer, :null=>false
			t.column :chat_id, :integer, :null=>false
		end
  end

  def self.down
    drop_table :mensaje_de_chats
  end
end
