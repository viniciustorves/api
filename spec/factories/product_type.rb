FactoryGirl.define do
  factory :product_type do
    sequence :name do |n|
      "Generic Type #{n}"
    end

    sequence :description do |n|
      "Generic type description #{n}."
    end

    trait :infrastructure do
      name 'Infrastructure'
    end

    trait :databases do
      name 'Databases'
    end

    trait :storage do
      name 'Storage'
    end

    transient do
      questions_count 2
      products_count 2
    end

    factory :database_product_type, traits: [:databases]
    factory :infrastructure_product_type, traits: [:infrastructure]
    factory :storage_product_type, traits: [:storage]
    after :create do |product_type, eva|
      create_list :product_type_question, eva.questions_count, product_type: product_type
      create_list :product, eva.products_count, product_type: product_type
    end
  end
end
