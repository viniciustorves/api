class ProductModule
  extend ActiveModel::Translation

  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::AttributeMethods
  include ActiveModel::Serializers::JSON

  include ActiveRecord::Scoping

  attr_accessor :module_name
  attr_reader :errors

  @@product_modules = Rails.application.config.jellyfish_product_modules

  validates :module_name, inclusion: { in: @@product_modules[:module_names] }

  def initialize(hash = {})
    hash.each do |key, value|
      send("#{key}=", value)
    end if hash

    @errors = ActiveModel::Errors.new(self)
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end

  def self.all
    @product_modules = []
    @@product_modules[:module_names].each do |mod|
      add_instance({module_name: mod})
    end
    return_module
  end

  def self.find(query)
    @product_modules = []
    case query
    when Hash
      query.each do |key, value|
        @@product_modules[:module_names].each do |mod|
          add_instance({module_name: mod}) if mod == value
        end
      end
    when Array, String
      Array(query).each do |value|
        @@product_modules[:module_names].each do |mod|
          add_instance({module_name: mod}) if mod == value
        end
      end
    end
    return_module
  end

  def self.first
    @product_modules = []
    add_instance({module_name: @@product_modules[:module_names].first})
    return_module
  end

  def self.last
    @product_modules = []
    add_instance({module_name: @@product_modules[:module_names].last})
    return_module
  end

  private

  def self.add_instance(hash)
    @product_modules << self.new.from_json(hash.to_json)
  end

  def self.return_module
    return @product_modules unless @product_modules.count <= 1
    @product_modules = @product_modules.first
  end
end
