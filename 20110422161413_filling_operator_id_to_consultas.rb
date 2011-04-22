class FillingOperatorIdToConsultas < ActiveRecord::Migration
  def self.up
    operador=Usuario.find_by_privilegio(4)
    Consulta.find_all_by_estado_id(Estado.find_by_estado("Finalizada").id) do |c|
      c.operador_id=operador.id
      save
    end
  end
  
  def self.down
  end
end
