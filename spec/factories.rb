FactoryGirl.define do
  factory :user do
    name "angdev"
  end

  factory :article do
    subject "read_activity"
    content "Hello, ReadActivity!"
  end
end