module TweetsHelper
  def sentiment_colour_finder(sentiment)
    if sentiment > 0
      return "positive"

    elsif sentiment == 0
      return "neutral"

    elsif sentiment < 0
      return "negative"
    end
  end 
end
