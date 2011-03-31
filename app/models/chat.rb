# == Schema Information
# Schema version: 19
#
# Table name: chats
#
#  id              :integer(4)      not null, primary key
#  fechaHoraInicio :datetime        not null
#  ultMensaje      :time            not null
#

class Chat < ActiveRecord::Base
	has_many :mensajesdechat
end
