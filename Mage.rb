require_relative 'Character'
class Mage < Character
	def initialize
		@strength = 16 
		@health = 125
		@speed = 10
		@intelligence = 20
		@luck = 2
	end
end
