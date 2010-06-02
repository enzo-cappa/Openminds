class CreateInfos < ActiveRecord::Migration
  def self.up
    create_table :infos do |t|
			t.column :nombre, :string, :null => false, :limit => 30
			t.column :desc, :string, :null => false, :limit => 100
			t.column :archivo, :string, :null => false, :limit => 30
			t.column :datos_binarios, :binary, :null => false
			t.column :tipo, :string, :null=>false
    end
  end

  def self.down
    drop_table :infos
  end
end
