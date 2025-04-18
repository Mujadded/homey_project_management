FactoryBot.define do
  factory :project_event do
    event_type { "MyString" }
    content { "MyText" }
    previous_status { "MyString" }
    new_status { "MyString" }
    user { nil }
    project { nil }
  end
end
