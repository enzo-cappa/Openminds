class AddingOperatorIdToConsultas < ActiveRecord::Migration
  def self.up
     add_column :abstract_consultas, :operador_id, :integer

  end

  def self.down
     remove_column :abstract_consultas, :operador_id
  end
end
