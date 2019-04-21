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
require_relative 'Troll'


class Tests
	

	def initialize(character)
		@hero = character
		@troll = Troll.new
		@spTest = 0
		@inTest = 0
		@bTest = 0
		@intel = @hero.intelligence + @hero.weapon.intelligence
		@sp = @hero.intelligence + @hero.weapon.speed
	end


	def addLine()
		puts "==============================================================="
	end
	

	#Simultes the battle phase
	def battleTest
		trollHealth = @troll.health
		heroHealth = @hero.health
		begin
			addLine()
			puts "Welcome to the Battle Phase"
			

			#Calculate Hero's stats
			heroDamage = @hero.strength + @hero.weapon.strength
			heroCritChance = @hero.luck
			heroCritDamage = heroDamage * 1.5
			#dodgechance ranges from 10%-40% where 10 is 10%
			heroDodgeChance = (@hero.luck*10)/2

			#Calculate troll's stats
			#dodgechance ranges from 10%-40% where 10 is 10%
			trollDodgeChance = @troll.luck * 10
			trollDamage = @troll.strength 
			trollCritChance = @troll.luck
			trollCritDamage = trollDamage * 1.1


			threads = []

			#Simulates Hero's attacks and Troll's chance to dodge his attacks
			threads << Thread.new{
				while trollHealth > 0 && heroHealth > 0
					#Case: Hero crits
					if (rand(100) + 1) <= heroCritChance * 10
						#calculates dodge chance out of 100 with hero dodge
						if rand(100) + 1 <= trollDodgeChance
							puts "[A: 0] \t You attacked the Troll for 0 damage (Miss)!!"
						else 						
							puts "[A: #{heroCritDamage}] \t You attacked the Troll for #{heroCritDamage} damage (Crit)!!"
							trollHealth -= heroCritDamage
						end
					#Case: Hero doesn't crit
					else 
						puts "[A: #{heroDamage}] \t You attacked the troll for #{heroDamage} damage!"
						trollHealth -= heroDamage
					end
					puts "Troll Health: #{trollHealth}\tHero Health: #{heroHealth}"
					sleep(0)
				end
			}
	
			#Simulates Troll's attacks and Hero's chance to dodge his attacks 
			threads << Thread.new{
				while trollHealth > 0 && heroHealth > 0 
					#Case: Troll crits
					if rand(100) + 1 <= trollCritChance * 10
						#calculates dodge chance out of 100 with hero dodge
						if rand(100) + 1 <= heroDodgeChance
							puts "[A: 0] \t The Troll attacked you for 0 damage (Miss)!!"
						else 						
							puts "[A: #{trollCritDamage}] \t The Troll attacked you for #{trollCritDamage} damage (Crit)!!"
							heroHealth -= trollCritDamage
						end
					#Case: Troll doesn't crit
					else 
						puts "[A: #{trollDamage}] \t The Troll attacked you for #{trollDamage} damage!"
						heroHealth -= trollDamage
					end
					puts "Troll Health: #{trollHealth}\tHero Health: #{heroHealth}"
					sleep(0)
				end
			}

			threads.each do |thread|
				thread.join
			end
	
			if heroHealth <= 0 
				puts "You lost! The Troll still had #{trollHealth} health remaining!"
			else
				puts "You won! The Troll still had #{trollHealth} health remaining!"
				@bTest = 1
			end
		end
	#call for next test
	nextTest
	end

	#Speed Test
	def speedTest()
		allotedTime = 10 * (@sp/100.0) + 7
		addLine()
		puts "Welcome to the speed test! In order to pass you must enter the sequence quick enough. Simple right?"
		begin
			puts "Enter the english alphabet all lowercase in the alloted time, if you fail you may try again. You have #{allotedTime} seconds"
			start = Time.now
			answer = gets.chomp
			finish = Time.now
			
			if answer != "abcdefghijklmnopqrstuvwxyz" 
				addLine()
				puts "You inputted the alphabet wrong. Try again."	
			end		
			diff = finish - start
			if diff > allotedTime 
				addLine()
				puts "Not fast enough. You finished in #{diff} seconds"
			end		
		end until answer == "abcdefghijklmnopqrstuvwxyz" && diff <= allotedTime
		puts "Congrats! You completed the test in #{diff} seconds"
		addLine()
		@spTest = 1
		nextTest
	end
	
	#Intelligence test
	#If character intel is 5(Easy), 15 (Normal), 20-25 (Easy)
	def intelligenceTest
		addLine()
		puts "Time to test your intelligence! In order to pass you must answer the riddle successfully."
		testing = true
		while testing do 
			#Easy level riddle
			if @intel == 5
				puts "Riddle: We hurt without moving. We poison without touching. We bear the truth and the lies. We are not to be judged by our size. What are we?"
				print "Your answer: "				
				answer = gets.chomp
				if answer.downcase.include? "word"
					testing = false
				else
					puts "That was the wrong answer. Try again!"
				end
			#Hard level riddle
			elsif @intel == 25
				puts "Riddle: What has 4 fingers and a thumb, but is not living?"
				print "Your answer: "
				answer = gets.chomp
				if answer.downcase.include? "glove"
					testing = false
				else
					puts "That was the wrong answer. Try again!"
				end
			#Medium level riddle
			elsif @intel == 15
				puts "Riddle: I can bring tears to your eyes; resurrect the dead, make you smile, and reverse time. I form in an instant but I last a life time. What am I?"
				print "Your answer: "
				answer = gets.chomp
				if answer.downcase.include? "memory" or answer.downcase.include? "memories"
					testing = false
				else
					puts "That was the wrong answer. Try again!"
				end
			end
			
		end
		puts "Congrats you passed the Intelligence Test!!"
		addLine()
		@inTest = 1
		nextTest
	end
	
	#Chooses next test based on whether user has passed or not
	def nextTest
		#Chose speed test as first and passed
		if @spTest == 1 && @bTest == 0 && @inTest == 0
			addLine()
			puts "Now choose from two other tests."
			puts "1 - Intelligence Test"
			puts "2 - Battle Test" 
			puts "3 - Quit Game"
			addLine()
			print "Enter your Choice: "
			begin	
				choice = gets.chomp.to_i
			end until choice >= 1 && choice <= 3
			if choice == 1
				intelligenceTest
				addLine()
				puts "Congratulations! You passed your second Test - Intelligence Test."
				puts "Onto your last test - Battle Test"
				addLine()
				battleTest
			elsif choice == 2
				addLine()
				battleTest
				puts "Congratulations! You passed your second Test - Battle Test."
				puts "Onto your last test - Speed Test"
				addLine()
				speedTest
			else 
				exit()
			end

		#Chose battle test as first and passed
		elsif @spTest == 0 && @bTest == 1 && @inTest == 0
			addLine()
			puts "Now choose from two other tests."
			puts "1 - Speed Test"
			puts "2 - Intelligence Test" 
			puts "3 - Quit Game"
			addLine()
			print "Enter your Choice: "
			begin	
				choice = gets.chomp.to_i
			end until choice >= 1 && choice <= 3
			if choice == 1
				speedTest
				addLine()
				puts "Congratulations! You passed your second Test - Speed Test."
				puts "Onto your last test - Intelligence Test"
				addLine()
				intelligenceTest
			elsif choice == 2
				intelligenceTest
				addLine()
				puts "Congratulations! You passed your second Test - Intelligence Test."
				puts "Onto your last test - Speed Test"
				addLine()
				speedTest
			else 
				exit()
			end

		#Chose intelligence test as first and passed
		elsif @spTest == 0 && @bTest == 0 && @inTest == 1
			addLine()
			puts "Now choose from two other tests."
			puts "1 - Speed Test"
			puts "2 - Battle Test"
			puts "3 - Quit Game"
			addLine()
			print "Enter your Choice: "
			begin	
				choice = gets.chomp.to_i
			end until choice >= 1 && choice <= 3
			if choice == 1
				speedTest
				puts "Onto your last test - Battle Test"
				battleTest
			elsif choice == 2
				battleTest
				puts "Onto your last test - Speed Test"
				speedTest
			else 
				exit()
			end

		#Continue prompt for hero not winning battle test
		else 
			if @bTest == 0
				puts "************************"
				puts "Do you wish to continue?"
				puts "1 - Restart Fight"
				puts "2 - Exit"
				puts "************************"
				print "Enter your Choice: "
				choice = gets.chomp.to_i
				case choice
				when 1 
					battleTest
				when 2
					exit()
				end
			end
		end
		
	end
		
end
