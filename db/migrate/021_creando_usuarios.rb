class CreandoUsuarios < ActiveRecord::Migration
  def self.up
        #crea un administrador por defecto
    Usuario.create(:nombre => 'Admin' , :apellido => 'Admin', :nomUsuario => 'admin', :contrasenia => 'admin', :fechaNac => Date.today, :privilegio => '7', :email => 'Admin@admin.com', :direccion => 'Admin', :provincia => 'Admin', :pais => 'Argentina', :fechaIng => Time.now,:operador_id=>1)

    #crea un operador por defecto
    Usuario.create(:nombre => 'operador' , :apellido => 'operandez', :nomUsuario => 'operador', :contrasenia => 'operador', :fechaNac => Date.today, :privilegio => '4', :email => 'op@op.com', :direccion => 'op', :provincia => 'Mendoza', :pais => 'Argentina', :fechaIng => Time.now, :operador_id=>1)

    #crea un usuario por defecto
    Usuario.create(:nombre => 'usuario' , :apellido => 'usuariez', :nomUsuario => 'usuario', :contrasenia => 'usuario', :fechaNac => Date.today, :privilegio => '1', :email => 'usuario@usuario.com', :direccion => 'op', :provincia => 'Mendoza', :pais => 'Argentina', :fechaIng => Time.now,:operador_id=>1)
  end

  def self.down
  end
end
