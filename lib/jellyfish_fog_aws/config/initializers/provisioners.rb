require 'jellyfish_fog_aws/databases'
require 'jellyfish_fog_aws/infrastructure'
require 'jellyfish_fog_aws/storage'

Rails.application.config.x.provisioners.merge!(
  JSON.parse(File.read(Jellyfish::Fog::AWS::Engine.root.join('config', 'provisioners.json')))
    .map { |product_type, provisioner| [product_type, provisioner.constantize] }.to_h
)
