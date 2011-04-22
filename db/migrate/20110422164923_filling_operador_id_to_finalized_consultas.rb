class FillingOperadorIdToFinalizedConsultas < ActiveRecord::Migration
  def self.up
    Consulta.find_all_by_estado_id(3) do |c|
      c.operador_id= Usuario.find_by_privilegio(4).id
      puts c.save
    end
  end

  def self.down
  end
end
