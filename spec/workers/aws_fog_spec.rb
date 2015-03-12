require 'rails_helper'

describe AwsFog do
  it 'creates a storage connection' do
    enable_aws_fog_provisioning
    order_item = create(:storage_order)
    Delayed::Worker.logger.debug "Create storage connection order_item name: #{order_item.product.product_type.name}"
    fog_instance = AwsFog.new(order_item.id)
    connection = fog_instance.storage_connection

    expect(connection).to be_a(Fog::Storage::AWS::Mock)
  end

  it 'creates a database connection' do
    enable_aws_fog_provisioning
    order_item = create(:db_order)
    prepare_db_products(order_item.product)
    fog_instance = AwsFog.new(order_item.id)
    connection = fog_instance.databases_connection

    expect(connection).to be_a(Fog::AWS::RDS::Mock)
  end

  it 'creates an infrastructure connection' do
    enable_aws_fog_provisioning
    order_item = create(:infrastructure_order)
    fog_instance = AwsFog.new(order_item.id)
    connection = fog_instance.infrastructure_connection

    expect(connection).to be_a(Fog::Compute::AWS::Mock)
  end

  describe '#provision' do
    it 'provisions infrastructure using fog' do
      enable_aws_fog_provisioning
      order_item = create(:infrastructure_order)
      provision_product order_item

      expect(order_item.provision_status).to eq 'ok'
      expect(order_item.payload_response).to be_present
    end

    it 'provisions databases using fog' do
      enable_aws_fog_provisioning
      order_item = create(:db_order)
      prepare_db_products(order_item.product)
      provision_product order_item

      expect(order_item.provision_status).to eq 'ok'
      expect(order_item.payload_response).to be_present
    end

    it 'provisions storage using fog' do
      enable_aws_fog_provisioning
      order_item = create(:storage_order)
      provision_product(order_item)

      expect(order_item.provision_status).to eq 'ok'
      expect(order_item.payload_response).to be_present
    end

    it 'returns a database identifier after provisioning' do
      enable_aws_fog_provisioning
      order_item = create(:db_order)
      prepare_db_products(order_item.product)
      provision_product order_item
      identifier = AwsFog.new(order_item.id).db_identifier

      expect(identifier).to be_a(String)
    end

    it 'returns a storage key after provisioning' do
      enable_aws_fog_provisioning
      order_item = create(:storage_order)
      provision_product order_item
      identifier = AwsFog.new(order_item.id).storage_key

      expect(identifier).to be_a(String)
    end

    it 'gets a server key after provisioning' do
      enable_aws_fog_provisioning
      order_item = create(:infrastructure_order)
      provision_product order_item
      identifier = AwsFog.new(order_item.id).server_identifier

      expect(identifier).to be_a(String)
    end
  end

  describe '#retire' do
    it 'retires infrastructure using fog' do
      enable_aws_fog_provisioning
      order_item = create(:infrastructure_order)
      provision_product order_item
      retire_product order_item

      expect(order_item.provision_status). to eq 'retired'
    end

    it 'retires databases using fog' do
      enable_aws_fog_provisioning
      order_item = create(:db_order)
      prepare_db_products(order_item.product)
      provision_product order_item
      retire_product order_item

      expect(order_item.provision_status). to eq 'retired'
    end

    it 'retires storage using fog' do
      enable_aws_fog_provisioning
      order_item = create(:storage_order)
      provision_product order_item
      retire_product order_item

      expect(order_item.provision_status). to eq 'retired'
    end
  end

  def provision_product(order_item)
    fog_provisioner = AwsFog.new(order_item.id)
    fog_provisioner.provision
    order_item.reload
  end

  def retire_product(order_item)
    AwsFog.new(order_item.id).retire
    order_item.reload
  end

  def prepare_db_products(product)
    q1 = create(:product_type_question, manageiq_key: 'allocated_storage', product_type: product.product_type)
    q2 = create(:product_type_question, manageiq_key: 'db_instance_class', product_type: product.product_type)
    q3 = create(:product_type_question, manageiq_key: 'engine', product_type: product.product_type)
    q4 = create(:product_type_question, manageiq_key: 'storage_type', product_type: product.product_type)
    create(:product_answer, product_id: product.id, product_type_question_id: q1.id, answer: '5')
    create(:product_answer, product_id: product.id, product_type_question_id: q2.id, answer: 'db.m3.medium')
    create(:product_answer, product_id: product.id, product_type_question_id: q3.id, answer: 'mysql')
    create(:product_answer, product_id: product.id, product_type_question_id: q4.id, answer: 'standard')
  end
end
