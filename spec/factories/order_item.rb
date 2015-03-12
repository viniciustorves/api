FactoryGirl.define do
  factory :order_item do
    order
    project
    product

    trait :database do
      product factory: :database_product
    end

    trait :storage do
      product factory: :storage_product
    end

    trait :infrastructure do
      product factory: :infrastructure_product
    end

    factory :db_order, traits: [:database]
    factory :storage_order, traits: [:storage]
    factory :infrastructure_order, traits: [:infrastructure]
  end
end
