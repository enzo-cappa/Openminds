class CrearTablaUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      #el id lo agrega solo
      t.column :nombre, :string,:null=>true,:limit=>20, :default=>''
      t.column :apellido, :string,:null=>true,:limit=>25, :default=>''
      t.column :nomUsuario, :string,:null=>true,:limit=>20, :default=>''
      t.column :fechaNac, :date, :null=>false
      t.column :privilegio, :integer, :null=>true, :default=>0
      t.column :email, :string,:null=>false,:limit=>40, :default=>''
      t.column :direccion, :string,:null=>false,:limit=>50, :default=>''
      t.column :provincia, :string,:null=>false,:limit=>20, :default=>''
      t.column :pais, :string,:null=>false,:limit=>20, :default=>''
      t.column :fechaIng, :datetime, :null=>false
      t.string :hashed_password
      t.string :salt
    end
  end
  def self.down
    drop_table :usuarios
  end
end
