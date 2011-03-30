# == Schema Information
# Schema version: 19
#
# Table name: aplicaciones
#
#  id     :integer(4)      not null, primary key
#  nombre :string(20)      default(""), not null
#

class Aplicacion < ActiveRecord::Base
end
