class AgregandoLogDeUsuarioAceptado < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :operador_id, :integer
  end

  def self.down
    remove_column :usuarios, :operador_id
  end
end
