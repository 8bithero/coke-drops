require 'rails_helper'

RSpec.describe TweetsHelper, type: :helper do
 
  describe "sentiment_colour_finder" do
  	
  	it "should return 'positive'" do
  		expect(sentiment_colour_finder(0.9)).to match(/positive/)
  	end

  	it "should return 'neutral'" do
  		expect(sentiment_colour_finder(0)).to match(/neutral/)
  	end

  	it "should return 'negative'" do
  		expect(sentiment_colour_finder(-0.9)).to match(/negative/)
  	end
  end
end

