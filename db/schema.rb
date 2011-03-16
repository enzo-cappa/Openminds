# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 19) do

  create_table "aplicaciones", :force => true do |t|
    t.string "nombre", :limit => 20, :default => "", :null => false
  end

  create_table "categorias", :force => true do |t|
    t.string "categoria", :limit => 25, :default => "", :null => false
  end

  create_table "chats", :force => true do |t|
    t.datetime "fechaHoraInicio", :null => false
    t.time     "ultMensaje",      :null => false
  end

  create_table "consultas", :force => true do |t|
    t.date    "fecha",                       :default => '2011-03-16', :null => false
    t.integer "estado_id",                                             :null => false
    t.string  "titulo",        :limit => 25, :default => "",           :null => false
    t.integer "usuario_id",                                            :null => false
    t.integer "aplicacion_id",                                         :null => false
    t.integer "categoria_id",                                          :null => false
  end

  create_table "estados", :force => true do |t|
    t.string "estado", :null => false
  end

  create_table "eventos", :force => true do |t|
    t.time   "fechaHora",                               :null => false
    t.string "desc",      :limit => 50, :default => "", :null => false
  end

  create_table "imagens", :force => true do |t|
    t.string  "content_type",   :null => false
    t.string  "archivo",        :null => false
    t.binary  "datos_binarios", :null => false
    t.integer "mensaje_id"
  end

  create_table "infos", :force => true do |t|
    t.string "nombre",         :limit => 30,  :null => false
    t.string "desc",           :limit => 100, :null => false
    t.string "archivo",        :limit => 30,  :null => false
    t.binary "datos_binarios",                :null => false
    t.string "tipo",                          :null => false
  end

  create_table "mensaje_de_chats", :force => true do |t|
    t.datetime "fechaHora",                 :default => '2011-03-16 00:00:00', :null => false
    t.text     "texto",      :limit => 255,                                    :null => false
    t.integer  "usuario_id",                                                   :null => false
    t.integer  "chat_id",                                                      :null => false
  end

  create_table "mensajes", :force => true do |t|
    t.datetime "fechaHora",                  :default => '2011-03-16 00:00:00', :null => false
    t.text     "texto",       :limit => 255,                                    :null => false
    t.integer  "usuario_id",                                                    :null => false
    t.string   "asunto",      :limit => 40,  :default => "",                    :null => false
    t.integer  "consulta_id",                                                   :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre",          :limit => 20, :default => ""
    t.string   "apellido",        :limit => 25, :default => ""
    t.string   "nomUsuario",      :limit => 20, :default => ""
    t.date     "fechaNac",                                      :null => false
    t.integer  "privilegio",                    :default => 0
    t.string   "email",           :limit => 40, :default => "", :null => false
    t.string   "direccion",       :limit => 50, :default => "", :null => false
    t.string   "provincia",       :limit => 20, :default => "", :null => false
    t.string   "pais",            :limit => 20, :default => "", :null => false
    t.datetime "fechaIng",                                      :null => false
    t.string   "hashed_password"
    t.string   "salt"
  end

end
