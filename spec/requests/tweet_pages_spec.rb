require 'spec_helper'

describe "Tweet pages" do

  subject { page }

  describe "index" do
    before { visit root_path }
    
    it { should have_title('CokeDrops') }

    describe "message list" do
      before(:all) do
        @tweets = FactoryGirl.create_list(:tweet, 5)
      end

      after(:all) { Tweet.delete_all }
      
      it { should have_selector('div.list-group') }
      it "should list each message" do
          expect(page).to have_selector('.list-group-item', count: Tweet.all.count)
      end
    end

    describe "empty message list" do
      it { should_not have_selector('.list-group-item') }
    end

    describe "elements & effects on page" do
      
      describe "filter buttons" do
        before(:all) do
          FactoryGirl.create_list(:tweet, 5)
          @tweet = Tweet.first
          visit root_path
        end
        after(:all) { Tweet.delete_all }

        it { should have_selector('#positive-filter') }
        it { should have_selector('#neutral-filter') }
        it { should have_selector('#negative-filter') }
      end
    end

    describe "Resetting Database" do
      before(:all) do
        FactoryGirl.create_list(:tweet, 5)
        @tweet = Tweet.first
        visit root_path
      end
      after(:all) { Tweet.delete_all }

      it "should delete all messages" do
        expect do
          click_link "Reset DB"
        end.to change(Tweet, :count).from(5).to(0)

      end
    end
  end


  describe "fetching tweets (:create)" do 

    describe "without error - status: 200" do
      before(:each) do
        stub_request(:get, "http://adaptive-test-api.herokuapp.com/tweets.json").
          to_return(:status => 200, :body => "[{
                        \"created_at\":\"2012-09-27T16:18:50Z\",
                        \"followers\":\"245\",
                        \"id\":\"14\",
                        \"message\":\"Coke coke coke coke coke!!!!\",
                        \"sentiment\":\"0.4\",
                        \"updated_at\":\"2012-09-27T16:18:50Z\",
                        \"user_handle\":\"@coke_snortr\"
                      },
                      {
                        \"created_at\":\"2012-09-27T16:18:09Z\",
                        \"followers\":\"3\",
                        \"id\":\"13\",
                        \"message\":\"I've got to say - Pepsi max is great!\",
                        \"sentiment\":\"0.9\",
                        \"updated_at\":\"2012-09-27T16:18:09Z\",
                        \"user_handle\":\"@tasteless\"
                      }]")
      
        visit root_path
      end

      it "creates two new records" do
        expect do
          click_link "Fetch more messages"
        end.to change(Tweet, :count).from(0).to(2)
      end

      it "increments tweet.counter if record already exists" do
        click_link "Fetch more messages"
        expect do
          click_link "Fetch more messages" 
        end.to change{Tweet.first.counter}.from(1).to(2)
      end

    end
  end
end