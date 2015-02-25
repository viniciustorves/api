class ProductResource
  extend ActiveModel::Translation

  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::AttributeMethods
  include ActiveModel::Serializers::JSON

  include ActiveRecord::Scoping

  attr_accessor :module_resource
  attr_reader :errors

  @@product_modules = Rails.application.config.jellyfish_product_modules

  validates :module_resource, inclusion: { in: @@product_modules[:module_resources].keys }

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
    @module_resources = []
    @@product_modules[:module_resources].each do |resource|
      Rails.logger.debug resource
      add_instance({module_resource: resource})
    end
    return_resource
  end

  def self.find(query)
    @module_resources = []
    case query
      when Hash
        query.each do |key, value|
          @@product_modules[:module_resources].each do |resource|
            add_instance({module_resource: resource}) if resource == value
          end
        end
      when Array, String
        Array(query).each do |value|
          @@product_modules[:module_resources].each do |resource|
            add_instance({module_resource: resource}) if resource == value
          end
        end
    end
    return_resource
  end

  def self.first
    @module_resources = []
    add_instance({module_resource: @@product_modules[:module_resources].first})
    return_resource
  end

  def self.last
    @module_resources = []
    add_instance({module_resouce: @@product_modules[:module_resources].last})
    return_resource
  end

  private

  def self.add_instance(hash)
    @module_resources << self.new.from_json(hash.to_json)
  end

  def self.return_resource
    return @module_resources unless @module_resources.count <= 1
    @module_resources = @module_resources.first
  end

  # def self.find(hash)
  #   @module_resources = []
  #   hash.each do |key, value|
  #     Rails.logger.debug key.to_s.pluralize.to_sym
  #     Rails.logger.debug value
  #     @@product_resources[key.to_s.pluralize.to_sym].each do |resource_type|
  #       Rails.logger.debug resource_type
  #       #Rails.logger.debug resource_name
  #       @module_resources << self.new.from_json({module_resource: resource_type}.to_json) if resource_type.to_s == value.to_sym
  #     end
  #   end
  #   @module_resources
  # end
end
