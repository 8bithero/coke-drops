class Tweet < ActiveRecord::Base

  # FILTERS & VALIDATIONS
  #-----------------------------------------------------------------------
  validates :message_id,   presence: true
  validates :message,      presence: true
  validates :user_handle,  presence: true

  WORDLIST = ["coke", "coca-cola", "diet cola"]

  scope :positive, -> { Tweet.where("sentiment > 0" ) }
  scope :neutral, -> { Tweet.where("sentiment = 0" ) }
  scope :negative, -> { Tweet.where("sentiment < 0" ) }


  # METHODS
  #-----------------------------------------------------------------------
  def self.get_new_tweets
    tweets = HTTParty.get "http://adaptive-test-api.herokuapp.com/tweets.json"
    # if response.success?
    #   JSON.parse(response.body)
    # end
  end

  # def load_new_tweets_json
  #   response = HTTParty.get(URI::encode('http://localhost:8081/producer.json?valid_date=' + Time.now.httpdate))
  #   if response.success?
  #     JSON.parse(response.body)
  #   end
  # end

  def self.save_tweets(new_tweets)
    @tweets = Tweet.all

    # raise new_tweets.inspect
    new_tweets.each do |tweet|
      # raise tweet.inspect
      if @tweets.where( message_id: tweet["id"]).exists?
        existing_tweet = @tweets.where( message_id: tweet["id"]).first
        
        existing_tweet.counter += 1
        existing_tweet.save!

      else
        censored_result = word_checker(tweet["message"])

        Tweet.create!(message_id: tweet["id"], 
                      message: tweet["message"],
                      user_handle: tweet["user_handle"],
                      sentiment: tweet["sentiment"],
                      censored: censored_result,
                      sent_at: tweet["created_at"],
                      counter: 1)
      end
    end
  end

  

  private
  def self.word_checker(message)
    result = false 
    WORDLIST.each { |word| result = true if message.include? word }
    result
  end
end
