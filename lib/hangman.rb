require 'yaml'
class Hangman
    def initialize
        @@attemps_left = 10
        @@incorrect_letters = []
        words = File.open('dictionary.txt').readlines.map{ |line| line.chomp.downcase}
        random = Random.new
        @@secret_word = words[random.rand(0..words.length)]
        @@guess_word = Array.new(@@secret_word.length,"_")

    end
    def play
        puts "Do you want to continue you last game y/n"
        load if gets.chomp == "y"  
        
        while (@@attemps_left > 0)
            guess
            break if (@@secret_word == @@guess_word)
        end
        puts "word was #{@@secret_word}"

            
            
        
        
    end
    def display
        puts @@guess_word.join
        puts "Remaining attemps #{@@attemps_left}"
        puts "Incorrect letters #{@@incorrect_letters}"
    end
    def to_s
        "#{@@secret_word}|#{@@guess_word}|#{@@attemps_left}|#{@@incorrect_letters}"
    end
    def save
        object = to_s
        File.write("savedgame.txt", object)
    end
    def load
        object = File.read("savedgame.txt")
        var = object.split("|")
        @@secret_word = var[0]
        @@guess_word = var[1].gsub!("[","").gsub!("]","").split(",")
        @@attemps_left = var[2].to_i
        @@incorrect_letters = var[3].gsub!("[","").gsub!("]","").split(",")

        
        end
    def guess
        #Guess the letter if incorrect attemps_left-1 and update monigote
        puts "Enter a character to guess or write save to save your progress "
        
        input = gets.chomp
        save if input == "save"
        if(@@secret_word.include? input)
            @@guess_word[@@secret_word.index(input)] = input
            display
        else
            @@incorrect_letters.append(input)
            puts "Keep Gueesing"
            @@attemps_left-=1
            display
    end
end
end

    game = Hangman.new
    game.play
    
