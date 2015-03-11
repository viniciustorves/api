require 'rails_helper'

describe Provisioner do
  it 'creates a new provisioner instance' do
    order_item = prepare_order_item
    Provisioner.new(order_item.id)
  end

  it 'capitalizes the cloud name' do
    order_item = prepare_order_item
    provisioner = Provisioner.new(order_item.id)

    expect(provisioner.cloud).to eq 'Test cloud'
  end

  it 'retrieves the name' do
    order_item = prepare_order_item
    provisioner = Provisioner.new(order_item.id)

    expect(provisioner.product_type).to eq 'product'
  end

  it 'returns hash of order details' do
    order_item = prepare_order_item
    provisioner = Provisioner.new(order_item.id)
    Delayed::Worker.logger.debug "Got the product provisioner: #{provisioner.order_item_details}"

    expect(provisioner.order_item_details).to be_a(Hash)
  end

  it 'returns the service type id' do
    order_item = prepare_order_item
    provisioner = Provisioner.new(order_item.id)

    expect(provisioner.service_type_id).to be_a(Numeric)
  end

  it 'saves a warning error' do
    order_item = prepare_order_item
    provisioner = Provisioner.new(order_item.id)
    provisioner.warning_error('a message')

    expect(provisioner.order_item.status_msg).to eq 'a message'
    expect(provisioner.order_item.provision_status).to eq 'warning'
  end

  it 'saves a critical error' do
    order_item = prepare_order_item
    provisioner = Provisioner.new(order_item.id)
    provisioner.critical_error('a critical error')

    expect(provisioner.order_item.status_msg).to eq 'a critical error'
    expect(provisioner.order_item.provision_status).to eq 'critical'
  end

  def prepare_order_item
    enable_aws_fog_provisioning
    create(
      :order_item,
      cloud: create(
        :cloud, name: 'test cloud'
      ),
      product: create(
        :product,
        product_type: create(:product_type, name: 'product'),
        name: 'rspec_product'
      )
    )
  end
end
