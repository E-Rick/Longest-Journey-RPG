require_relative 'Character'
require_relative 'Tests'
require_relative 'Weapon'
require_relative 'Warrior'
require_relative 'Rouge'
require_relative 'Mage'
require_relative 'Archer'
require_relative 'ThrowKnives'
require_relative 'TwinSwords'
require_relative 'MagicTomb'
require_relative 'GreatSword'

def title
	puts "************************************************"
	puts "    ++++++++++++++++++++++++++++++++++++++++"
	puts "+++++               WELCOME                +++++"
	puts "+++++        TO THE LONGEST JOURNEY        +++++"
	puts "    ++++++++++++++++++++++++++++++++++++++++"
	puts "************************************************"
end
#Returns user's chosen menu
def startMenu
	puts "=============== START MENU ==============="
	puts "1 - Create your Character"
	puts "2 - Exit"
	puts "========================================="
	print"Enter your choice: "
	begin
		choice = gets.chomp.to_i
	end until choice == 1 || choice == 2
	return choice
end

def addLine
	puts "==============================================================="
end


#Returns user's chosen hero
def createChar
	#Character set up
	addLine()
	puts "Please choose a hero by typing the number next to the hero type."
	puts "Listed next to each hero is their strength and weaknesses."
	puts "1 - Warrior (+1 Strength, +25 Health, -5 Speed, -5 Intelligence, +1 Luck)"
	puts "2 - Rouge   (+1 Strength, -25 Health, +5 Speed, -5 Intelligence, +3 Luck)"
	puts "3 - Mage    (+1 Strength, -25 Health, -5 Speed, +5 Intelligence, +2 Luck)"
	puts "4 - Archer  (-1 Strength, -25 Health, +5 Speed, +5 Intelligence, +4 Luck)"
	addLine()
	print"Enter your choice: "
	begin	
		race = gets.chomp.to_i
	end until race >= 1 && race <= 4
	return race
end

#Returns user's chosen weapon
def chooseWeap
	addLine()
	puts "Now choose choose carefully a weapon for your character."
	puts "1 - Twin Swords (+2 Strength, -25 Health, +5 Speed, -5 Intelligence)"
	puts "2 - Great Sword (+2 Strength, -25 Health, -5 Speed, +5 Intelligence)"
	puts "3 - Magic Tomb  (-2 Strength, -25 Health, +5 Speed, +5 Intelligence)"
	puts "4 - Throw Knives(-2 Strength, +25 Health, +5 Speed, -5 Intelligence)"
	addLine()
	print"Enter your choice: "
	begin	
		weapon = gets.chomp.to_i
	end until weapon >= 1 && weapon <= 4

	return weapon
end

#Returns user's first choice for test
def startTests
	#Start Tests
	addLine()
	puts "Choose your first test from the following three."
	puts "1 - Speed Test"
	puts "2 - Intelligence Test"
	puts "3 - Battle Test" 	
	addLine()
	print"Enter your choice: "
	begin	
		choice = gets.chomp.to_i	
	end until choice >= 1 && choice <= 3

	return choice
end

	

def main
	title()
	choice = startMenu()
	case choice 
	when 1
		#Create Hero here
		character = createChar()
		case character
		when 1
			hero = Warrior.new
		when 2
			hero = Rouge.new
		when 3
			hero = Mage.new
		when 4
			hero = Archer.new
		end
	when 2
		exit()
	end
	

	weapon = chooseWeap()
	#setweapon
	hero.setWeapon(weapon)
	hero.toString()

	#Create test object
	tester = Tests.new(hero)
	choice = startTests
	case choice
	when 1
		tester.speedTest
	when 2
		tester.intelligenceTest
	when 3
		tester.battleTest
	end
	addLine()
	puts "*****You have completed the Games congrats!!!*****"
	
end
main
