FactoryGirl.define do
  factory :article do
    trait :released do
      published_at 1.minute.ago
      slug 'a-test-article'
    end
  end
end
