class ProductResource
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::AttributeMethods
  include ActiveModel::Serializers::JSON
  include ActiveRecord::Scoping

  attr_accessor :name, :description, :questions, :load_order
  #has_many :product_types

  validates_each :product_module do |record, attr, value|
    record.errors.add attr, 'No such module.' if !@@product_modules[:module_names].include?(value)
  end

  @@product_modules = Rails.application.config.jellyfish_product_modules[:module_names]
  @@product_resources = Rails.application.config.jellyfish_product_modules[:module_resources]
  #has_many :product_type

  def self.all
    @module_resources = []
    @@product_resources.each do |resource|
      @module_resources << self.new.from_json({module_resource: resource}.to_json)
    end
    @module_resources
  end

  def self.find(hash)
    @module_resources = []
    hash.each do |key, value|
      @@product_resources.each do |resource|
        @module_resources << self.new.from_json({module_resource: resource}.to_json) if resource == value
      end
    end
    @module_resources
  end
end
