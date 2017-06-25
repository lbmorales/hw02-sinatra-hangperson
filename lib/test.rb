### Comprobar por que este metodo explota los tests de aceptacion
### sin embargo corren bien los unitarios
# bundle exec autotest (OK)
# cucumber features/guess.feature (falla cuando esta este metodo)

def word_with_guesses(word, guesses)
  word.gsub!('-') if guesses.size.zero?
  word.each_char do |c|
    word.gsub!(c, '-') unless guesses.match(c)
  end
  word
end

# def word_gesses(word, guesses)
#   g = ''
#   word.each_char do |c|
#     g << if guesses.include?(c)
#            c
#          else
#            '-'
#          end
#   end
#   g
# end

w = 'banana'
gues = 'an'
puts word_with_guesses(w, gues)
# puts word_gesses(w, gues)

# ch = '0'
# def l(character)
#   puts raise ArgumentError if character.nil? || character.empty? || character !~ /[a-zA-Z]/
# end
# puts l(ch)