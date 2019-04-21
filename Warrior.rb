require_relative 'Character'
class Warrior < Character
	def initialize
		@strength = 16 
		@health = 175
		@speed = 10
		@intelligence = 10
		@luck = 1
	end
end
