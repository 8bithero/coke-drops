require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TweetsHelper. For example:
#
# describe TweetsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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

