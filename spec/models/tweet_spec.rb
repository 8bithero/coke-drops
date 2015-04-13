require 'rails_helper'

RSpec.describe Tweet, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:tweet)).to be_valid
  end
  it { is_expected.to respond_to(:message_id) }
  it { is_expected.to respond_to(:message) }
  it { is_expected.to respond_to(:user_handle) }
  it { is_expected.to respond_to(:sentiment) }
  it { is_expected.to respond_to(:censored) }
  it { is_expected.to respond_to(:sent_at) }
  it { is_expected.to respond_to(:counter) }

  describe '#get_new_tweets' do
    it 'calls API for tweets' do
      
      expect(HTTParty).to receive(:get)#.and_return(results)

      Tweet.get_new_tweets
    end
  end

  describe "#save_tweets" do
    before(:each) do 
      @tweets_one = [
        {
          "created_at" => "2012-09-27T16:18:50Z",
          "followers" => 245,
          "id" => 14,
          "message" => "Coke coke coke coke coke!!!!",
          "sentiment" => 0.4,
          "updated_at" => "2012-09-27T16:18:50Z",
          "user_handle" => "@coke_snortr"
        },
        {
          "created_at" => "2012-09-27T16:18:09Z",
          "followers" => 3,
          "id" => 13,
          "message" => "I've got to say - Pepsi max is great!",
          "sentiment" => 0.9,
          "updated_at" => "2012-09-27T16:18:09Z",
          "user_handle" => "@tasteless"
        }
      ]
      @msg_id_1 = 14
      @msg_id_2 = 13
    end

    describe "server returns two new messages" do
      it "should create two new records" do
        expect{Tweet.save_tweets(@tweets_one)}.to change{Tweet.count}.by(2)
      end
    end

    describe "server returns one duplicate message" do
      before(:each) do
        Tweet.save_tweets(@tweets_one)
        @tweets_two = [{
                        "created_at" => "2012-09-27T16:18:50Z",
                        "followers" => 245,
                        "id" => 14,
                        "message" => "Coke coke coke coke coke!!!!",
                        "sentiment" => 0.4,
                        "updated_at" => "2012-09-27T16:18:50Z",
                        "user_handle" => "@coke_snortr"
                      },
                      {
                        "created_at" => "2012-09-27T16:18:09Z",
                        "followers" => 3,
                        "id" => 17,
                        "message" => "Coke is great",
                        "sentiment" => 0.7,
                        "updated_at" => "2012-09-27T16:18:09Z",
                        "user_handle" => "@coke_lvr"
                      }]
      end

      it "should create one new records" do
        expect{Tweet.save_tweets(@tweets_two)}.to change{Tweet.count}.by(1)
      end

      it "should modify one records" do
        expect{Tweet.save_tweets(@tweets_two)}.to change{Tweet.where(message_id: @msg_id_1).first.counter}.from(1).to(2)
      end
    end

    describe "server returns two duplicate messages" do
      before(:each) do
        Tweet.save_tweets(@tweets_one)
      end

      it "should not create new record" do
        expect{Tweet.save_tweets(@tweets_one)}.to_not change{Tweet.count}
      end

      it "should modify two existing records" do
        expect{Tweet.save_tweets(@tweets_one)}.to change{Tweet.where(message_id: @msg_id_1).first.counter}.by(1)
        expect{Tweet.save_tweets(@tweets_one)}.to change{Tweet.where(message_id: @msg_id_2).first.counter}.by(1)
      end
    end
  end

end