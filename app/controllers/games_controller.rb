class GamesController < ApplicationController
  def new
    alpha = ('a'..'z').to_a
    @letters = Array.new(10) { alpha.sample }
  end

  require 'json'
  require 'open-uri'

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:attempt]}"
    response = URI.open(url).read
    result = JSON.parse(response)
    result['found']
  end

  def can_make_word?
    @letters = params[:random_letters].chars
    attempt = params[:attempt]
    attempt.chars.all? { |letter| attempt.count(letter) <= @letters.count(letter) }
  end

  def score
    @letters = params[:random_letters]

    if (can_make_word? == true) && (english_word? == true)
      @score = params[:attempt].split("").count
    else
      @score = 0
    end
  end
end
