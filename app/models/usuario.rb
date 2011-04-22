# == Schema Information
# Schema version: 20110412010439
#
# Table name: usuarios
#
#  id              :integer(4)      not null, primary key
#  nombre          :string(20)      default("")
#  apellido        :string(25)      default("")
#  nomUsuario      :string(20)      default("")
#  privilegio      :integer(4)      default(0)
#  email           :string(40)      default(""), not null
#  direccion       :string(50)      default(""), not null
#  provincia       :string(20)      default(""), not null
#  pais            :string(20)      default(""), not null
#  fechaIng        :datetime        not null
#  hashed_password :string(255)
#  salt            :string(255)
#

require 'digest/sha1'

class Usuario < ActiveRecord::Base
  
  attr_accessor :contrasenia_confirmation
  cattr_reader :per_page
  @@per_page = 10
  has_many :consultas
  has_many :mensajes
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "El mail ingresado no es correcto"
  validates_uniqueness_of :nomUsuario, :message => "Ya existe el usuario con ese nombre"
  validates_length_of :nombre, :within => 1..20, :message => "La cantidad de caracteres para nombre no puede ser mayor a 21 ni menor a 1"
  validates_length_of :apellido, :within => 1..25, :message => "La cantidad de caracteres para apellido no puede ser mayor a 21 ni menor a 1"
  validates_length_of :nomUsuario, :within => 1..20, :message => "La cantidad de caracteres para nombre de usuario no puede ser mayor a 21 ni menor a 1"
  has_one :operador, :class_name => "Usuario", :foreign_key => "operador_id"
  has_many :cerradas, :class_name => "Consulta", :foreign_key=>"operador_id"
  validates_confirmation_of :contrasenia
  validate :contrasenia_no_vacia

  after_destroy :verificar_no_ultimo
  before_save :actualizar_fecha_ingreso

  private
  
  def muestraFecha(fecha)
    return fecha.strftime("%d/%m/%y %I:%M%p")
  end

  def contrasenia_no_vacia
    errors.add(:contrasenia, "Falta la contrasenia" ) if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def  verificar_no_ultimo
    if Usuario.count.zero?
      raise "No se puede borrar el ultimo usuario"
    end
  end

  public

  def actualizar_fecha_ingreso
    self.fechaIng=Time.now
  end
  
  def admitir(operador)
    if 1 > self.privilegio
      self.operador_id=operador
      self.privilegio=1
      self.save
    end
  end

  def contrasenia
    @password
  end

  def contrasenia=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Usuario.encrypted_password(self.contrasenia, self.salt)
  end

  def self.filtro(criterio,clave,orden,privilegio=0)
    relacion=Usuario.where(criterio.to_sym =~ "%#{clave}%",:privilegio <= privilegio)
    relacion.order(orden)
  end


  def self.autenticar(name, password)
    user = self.find_by_nombre(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
end
