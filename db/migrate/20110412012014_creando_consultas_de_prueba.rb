class CreandoConsultasDePrueba < ActiveRecord::Migration
  def self.up
    numero=0
    40.times do 
       c=Consulta.new
       c.usuario_id=Usuario.find_by_privilegio(1).id
       c.estado_id=rand(3)+1
       c.titulo= "#{numero} - consulta usuario"
       c.aplicacion_id=rand(3)+1
       c.categoria_id=rand(3)+1
       c.save
       numero=numero+1
    end
  end

  def self.down
     Consulta.destroy_all
  end
end
