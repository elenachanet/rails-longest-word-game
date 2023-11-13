class GamesController < ApplicationController
  require 'open-uri'

  def new
  @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @grid = JSON.parse(params[:grid])
    if check_letters(@word, @grid) && english_word?(@word)
      @word = "C'est ok"
    else
      @word = "Marche pas"
    end
  end

  def check_letters(word, letters)
    word.split('').each do |letter|
      return false unless letters.include?(letter.upcase)
    end
  end


def english_word?(word)
  response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end

end
