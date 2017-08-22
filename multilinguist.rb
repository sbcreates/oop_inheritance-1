require 'httparty'
require 'json'


# This class represents a world traveller who knows what languages are spoken in each country
# around the world and can cobble together a sentence in most of them (but not very well)
class Multilinguist

  TRANSLTR_BASE_URL = "http://bitmakertranslate.herokuapp.com"
  COUNTRIES_BASE_URL = "https://restcountries.eu/rest/v2/name"
  #{name}?fullText=true
  #?text=The%20total%20is%2020485&to=ja&from=en


  # Initializes the multilinguist's @current_lang to 'en'
  #
  # @return [Multilinguist] A new instance of Multilinguist
  def initialize
    @current_lang = 'en'
  end

  # Uses the RestCountries API to look up one of the languages
  # spoken in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] A 2 letter iso639_1 language code
  def language_in(country_name)
    params = {query: {fullText: 'true'}}
    response = HTTParty.get("#{COUNTRIES_BASE_URL}/#{country_name}", params)
    json_response = JSON.parse(response.body)
    json_response.first['languages'].first['iso639_1']
  end

  # Sets @current_lang to one of the languages spoken
  # in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] The new value of @current_lang as a 2 letter iso639_1 code
  def travel_to(country_name)
    local_lang = language_in(country_name)
    @current_lang = local_lang
  end

  # (Roughly) translates msg into @current_lang using the Transltr API
  #
  # @param msg [String] A message to be translated
  # @return [String] A rough translation of msg
  def say_in_local_language(msg)
    params = {query: {text: msg, to: @current_lang, from: 'en'}}
    response = HTTParty.get(TRANSLTR_BASE_URL, params)
    json_response = JSON.parse(response.body)
    json_response['translationText']
  end
end


class MathGenius < Multilinguist

  def report_total(*nums)
    puts "The total is #{nums.sum}"
  end

end



class QuoteCollector < Multilinguist

  def initialize
    @favorite_quotes = []
  end

#READER
  def favorite_quotes
    @favorite_quotes
  end

#can add a new favorite quote into the favorite quotes array
  def add_fav_quote(quote)
    @favorite_quotes << quote
  end

end


me = MathGenius.new
puts me.report_total(2, 34, 5, 56, 67, 78, 2, 6, 7, 9, 2, 5, 3, 7)
me.travel_to("Italy")
puts me.report_total(2, 34, 5, 56, 67, 78, 2, 6, 7, 9, 2, 5, 3, 7)

you = QuoteCollector.new
puts you.favorite_quotes
you.add_fav_quote("Hello World")
puts you.favorite_quotes
you.language_in("Italy")
you.add_fav_quote("Hello World")
puts you.favorite_quotes
