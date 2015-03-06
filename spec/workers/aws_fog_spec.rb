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
    order_item = prepare_fog_spec 'databases'

    fog_provisioner = AwsFog.new(order_item.id)
    fog_provisioner.provision
    order_item.reload

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
end
