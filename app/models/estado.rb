# == Schema Information
# Schema version: 19
#
# Table name: estados
#
#  id     :integer(4)      not null, primary key
#  estado :string(255)     not null
#

class Estado < ActiveRecord::Base
	has_many :consultas
	
end
