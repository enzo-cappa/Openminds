class LlenandoOperadorIdDeUsuario < ActiveRecord::Migration
  def self.up
    Usuario.all.each do |u|
      u.operador_id=Usuario.find_by_privilegio(7).id
      u.save
    end
  end

  def self.down
  end
end
