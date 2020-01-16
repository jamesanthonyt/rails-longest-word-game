require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array('A'..'Z').sample(9)
  end

  def score
    session[:score] = '100'
    @test = session[:score]
    @grid = params[:letters]
    @guess = params[:guess].upcase
    @api_response = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@guess}").read)
    @valid_word = true if @api_response['found'] == true
    @match = match?(@guess, @grid)
    @score = @match == true && @valid_word == true ? @guess.length : 0
  end

  private

  def match?(guess, grid)
    true if guess.chars.all? { |letter| guess.count(letter) <= grid.chars.count(letter) }
  end
end
