# == Schema Information
# Schema version: 19
#
# Table name: categorias
#
#  id        :integer(4)      not null, primary key
#  categoria :string(25)      default(""), not null
#

class Categoria < ActiveRecord::Base
end
