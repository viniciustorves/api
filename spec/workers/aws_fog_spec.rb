require 'rails_helper'

describe AwsFog do
  it 'provisions infrastructure using fog' do
    order_item = prepare_fog_spec 'Infrastructure'
    provision_product order_item
  end

  it 'provisions databases using fog' do
    order_item = prepare_fog_spec 'Databases'
    prepare_db_products
    provision_product order_item
  end

  it 'provisions storage using fog' do
    order_item = prepare_fog_spec 'Storage'
    provision_product(order_item)
  end

  it 'retires infrastructure using fog' do
    order_item = prepare_fog_spec 'Infrastructure'
    provision_product order_item
    retire_product order_item
  end

  it 'retires databases using fog' do
    order_item = prepare_fog_spec 'Databases'
    prepare_db_products
    provision_product order_item
    retire_product order_item
  end

  it 'retires storage using fog' do
    order_item = prepare_fog_spec 'Storage'
    provision_product order_item
    retire_product order_item
  end

  def provision_product(order_item)
    fog_provisioner = AwsFog.new(order_item.id)
    fog_provisioner.provision
    order_item.reload
    expect(order_item.provision_status).to eq 'ok'
    expect(order_item.payload_response).to be_present
  end

  def retire_product(order_item)
    AwsFog.new(order_item.id).retire
    order_item.reload
    expect(order_item.provision_status). to eq 'retired'
  end

  def prepare_fog_spec(name)
    enable_aws_fog_provisioning
    create(
      :order_item,
      product: create(
        :product,
        product_type: create(:product_type, name: name),
        name: 'rspec_product'
      )
    )
  end

  def prepare_db_products
    # All of these product type questions and answers are necessary for provisioning of a database
    ProductTypeQuestion.create([
      { product_type_id: ProductType.find_by(name: 'Databases').id, manageiq_key: 'allocated_storage' },
      { product_type_id: ProductType.find_by(name: 'Databases').id, manageiq_key: 'db_instance_class' },
      { product_type_id: ProductType.find_by(name: 'Databases').id, manageiq_key: 'engine' },
      { product_type_id: ProductType.find_by(name: 'Databases').id, manageiq_key: 'storage_type' }
    ])
    ProductAnswer.create([
      { product_id: Product.find_by(name: 'rspec_product').id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'allocated_storage').id, answer: '5' },
      { product_id: Product.find_by(name: 'rspec_product').id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'db_instance_class').id, answer: 'db.m3.medium' },
      { product_id: Product.find_by(name: 'rspec_product').id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'engine').id, answer: 'mysql' },
      { product_id: Product.find_by(name: 'rspec_product').id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'storage_type').id, answer: 'standard' }
    ])
  end
end
