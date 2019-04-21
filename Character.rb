class Character 
	attr_reader :health
	attr_reader :strength
	attr_reader :intelligence
	attr_reader :speed
	attr_reader :luck

	def initialize 
		raise NoMethodError
	end

	#sets hero's weapon
	def setWeapon(weapon)
		if weapon == 1
			@weapon = TwinSwords.new
		elsif weapon == 2 
			@weapon = GreatSword.new
		elsif weapon == 3 
			@weapon = MagicTomb.new
		elsif weapon == 4
			@weapon = ThrowKnives.new 
		end
	end

	def weapon 
		@weapon
	end

	#To string method to print hero stats
	def toString
		hp = @health + @weapon.health
		str = @strength + @weapon.strength
		inte = @intelligence + @weapon.intelligence
		sp = @speed + @weapon.speed
		puts "=================== HERO STATS ==================="
		puts "		Weapon:      #{@weapon.class.name}"
		puts "		Health:      #{hp}"
		puts "		Strength:    #{str}"
		puts "		Intelligence:#{inte}"
		puts "		Speed:       #{sp}"
		puts "		Luck:        #{luck}"
		puts "===================            ==================="
	end
	

	
end


