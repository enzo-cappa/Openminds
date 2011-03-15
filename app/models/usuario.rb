class Usuario < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  
	has_many :consultas	
	has_many :mensajes
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "El mail ingresado no es correcto"
	validates_uniqueness_of :nomUsuario, :message => "Ya existe el usuario con ese nombre"
	validates_length_of :nombre, :within => 1..20, :message => "La cantidad de caracteres para nombre no puede ser mayor a 21 ni menor a 1"
	validates_length_of :apellido, :within => 1..25, :message => "La cantidad de caracteres para apellido no puede ser mayor a 21 ni menor a 1"
	validates_length_of :nomUsuario, :within => 1..20, :message => "La cantidad de caracteres para nombre de usuario no puede ser mayor a 21 ni menor a 1"
	validates_length_of :contrasenia, :within => 5..32, :message => "La contrase�a debe tener al menos 5 caracteres y un maximo de 32"

  private
  def muestraFecha(fecha)
    return fecha.strftime("%d/%m/%y %I:%M%p")
  end

  public
  def before_save
    self.fechaIng=Time.now
  end
  def admitir
    if 1 > self.privilegio
      self.privilegio=1
      self.save
    end
  end
end