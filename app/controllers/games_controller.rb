require 'open-uri'
require 'json'
# doc info
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }.join
  end

  def letter_included?
    params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].count(letter) }
  end

  def score
    if letter_included?
      if english_word(params[:word])
        @score = true
        return @score
      end
    end
  end


  def english_word(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

#   def run_game(params[:word], grid, start_time, end_time)
#     result = { time: end_time - start_time }
#     score_and_output = score_and_output(params[:word], grid, result[:time])
#     result[:score] = score_and_output.first
#     result[:message] = score_and_output.last
#     result
#     # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
#   end
# end
