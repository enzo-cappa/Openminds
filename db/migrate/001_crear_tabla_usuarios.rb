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
    #crea un administrador por defecto
    Usuario.create(:nombre => 'Admin' , :apellido => 'Admin', :nomUsuario => 'admin', :contrasenia => 'Admin', :fechaNac => Date.today, :privilegio => '7', :email => 'Admin@admin.com', :direccion => 'Admin', :provincia => 'Admin', :pais => 'Argentina', :fechaIng => Time.now)
	
    #crea un operador por defecto
    Usuario.create(:nombre => 'operador' , :apellido => 'operandez', :nomUsuario => 'operador', :contrasenia => 'operador', :fechaNac => Date.today, :privilegio => '4', :email => 'op@op.com', :direccion => 'op', :provincia => 'Mendoza', :pais => 'Argentina', :fechaIng => Time.now)
	
    #crea un usuario por defecto
    Usuario.create(:nombre => 'usuario' , :apellido => 'usuariez', :nomUsuario => 'usuario', :contrasenia => 'usuario', :fechaNac => Date.today, :privilegio => '1', :email => 'usuario@usuario.com', :direccion => 'op', :provincia => 'Mendoza', :pais => 'Argentina', :fechaIng => Time.now)
  end

  def self.down
    drop_table :usuarios
  end
end
