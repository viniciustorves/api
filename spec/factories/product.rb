FactoryGirl.define do
  factory :product do
    active true
    img 'product.png'

    sequence :name do |n|
      "Product Name #{n}"
    end

    sequence :description do |n|
      "Product description #{n}"
    end

    provisionable factory: :manage_iq_product

    product_type

    trait :databases do
      product_type factory: :database_product_type
    end

    trait :infrastructure do
      product_type factory: :infrastructure_product_type
    end

    trait :storage do
      product_type factory: :storage_product_type
    end

    factory :database_product, traits: [:databases]
    factory :infrastructure_product, traits: [:infrastructure]
    factory :storage_product, traits: [:storage]

    after :create do |product|
      product.product_type.questions.each do |question|
        create :product_answer, product: product, product_type_question_id: question.id
      end
    end
  end
end
