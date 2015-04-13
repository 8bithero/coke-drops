FactoryGirl.define do
  factory :tweet do
    sequence(:message_id)
    message "This is a coke message"
    censored true
    sequence(:user_handle) { |n| "person_#{n}" }
    sentiment 0.9
    sent_at Time.zone.now
    counter 1
    # followers rand(0..20)
    # created_at Time.zone.now
    # updated_at Time.zone.now
  end
end
