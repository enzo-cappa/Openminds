class CreateAplicacions < ActiveRecord::Migration
  def self.up
    create_table :aplicacions do |t|
		t.column :nombre, :string, :null=>false, :limit=>20, :default=>''		
    end
  end

  def self.down
    drop_table :aplicacions
  end
end
