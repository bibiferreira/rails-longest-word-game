require "open-uri"
require 'json'

class ApplicationController < ActionController::Base
  def home
    //
    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "z"]

    letters = []
    (0...10).each do |index|
      randomIndex = rand(alphabet.count)
      letters.push(alphabet[randomIndex].upcase)
    end

    @grid = letters.join(', ')
  end

  def submit
    # pegar a palavra vinda de params
    word = params[:word].upcase

    # pegar o grid vindo de params
    grid = params[:grid].split(", ")

    # apenas letras vindas do grid
    valid = true
    word.chars.each do |char|
      valid = valid && grid.include?(char)
    end

    if !valid
      @message = "invalid word"
      return
    end

    # tem que ser uma palavra valida
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    buffer = URI.open(url).read
    result = JSON.parse(buffer)
    if !result["found"]
      @message = "invalid word"
      return
    end

    @message = "#{word} is a valid word"
  end
end
