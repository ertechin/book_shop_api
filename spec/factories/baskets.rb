FactoryBot.define do
  factory :basket do
    user
    data { {4 => {quantity: "1"}} }
  end
end