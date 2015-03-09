require 'rails_helper'

describe AwsFog do
  it 'provisions infrastructure using fog' do
    order_item = prepare_fog_spec 'infrastructure'
    fog_provisioner = AwsFog.new(order_item.id)
    fog_provisioner.provision
    order_item.reload

    expect(order_item.provision_status).to eq 'ok'
    expect(order_item.payload_response).to be_present
  end

  it 'provisions databases using fog' do
    order_item = prepare_db_spec
    fog_provisioner = AwsFog.new(order_item.id)
    begin
      fog_provisioner.provision
      order_item.reload
    rescue StandardError => e
      Delayed::Worker.logger.debug "DB: Caught an error: #{e.message}"
    end
    expect(order_item.provision_status).to eq 'ok'
    expect(order_item.payload_response).to be_present
  end

  it 'provisions storage using fog' do
    order_item = prepare_fog_spec 'storage'

    fog_provisioner = AwsFog.new(order_item.id)
    fog_provisioner.provision
    order_item.reload

    expect(order_item.provision_status).to eq 'ok'
    expect(order_item.payload_response).to be_present
  end

  def prepare_fog_spec(name)
    enable_aws_fog_provisioning

    create(
      :order_item,
      product: create(
        :product,
        product_type: create(:product_type, name: name)
      )
    )
  end

  def prepare_db_spec
    enable_aws_fog_provisioning
    product_type = create(:product_type, name: 'Databases')
    product = create(:product, product_type: product_type)
    ProductTypeQuestion.create([
       {product_type_id: product_type.id, manageiq_key: 'allocated_storage'},
       {product_type_id: product_type.id, manageiq_key: 'db_instance_class'},
       {product_type_id: product_type.id, manageiq_key: 'engine'},
       {product_type_id: product_type.id, manageiq_key: 'storage_type'}
    ])
    ProductAnswer.create([
      {product_id: product.id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'allocated_storage').id, answer: '5'},
      {product_id: product.id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'db_instance_class').id, answer: 'db.m3.medium'},
      {product_id: product.id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'engine').id, answer: 'mysql'},
      {product_id: product.id, product_type_question_id: ProductTypeQuestion.find_by(manageiq_key: 'storage_type').id, answer: 'standard'}
    ])
    create(:order_item, product: product)
  end
end
