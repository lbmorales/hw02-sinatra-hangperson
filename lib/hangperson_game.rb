class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word, guesses = '', wrong_guesses = '')
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri, {}).body
  end

  def guess(character)
    raise ArgumentError if character.nil? || character.empty? || character !~ /[a-zA-Z]+/
    character.downcase!
    if word.include?(character) && !guesses.include?(character)
      guesses << character
      true
    elsif !word.include?(character) && !wrong_guesses.include?(character)
      wrong_guesses << character
      true
    else
      false
    end
  end

  def word_with_guesses
    w = ''
    word.each_char do |c|
      w << if guesses.include?(c)
             c
           else
             '-'
           end
    end
    w
  end

  def check_win_or_lose
    return :win if word_with_guesses !~ /(\-)+/
    return :lose if wrong_guesses.size >= 7
    :play
  end
end
