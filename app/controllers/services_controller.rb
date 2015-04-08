class ServicesController < ApplicationController
  # after_action :verify_authorized

  api :GET, '/services', 'Returns a collection of services'
  def index
    # TODO: FILTER TO ONLY USER SERVICES, NOT ALL SERVICES
    services = OrderItem.all
    render json: services
  end

  # TODO: INVESTIGATE WHY THIS WAS LEFT IN HERE
  # def show
  #   json = DummyController.service_json(params[:id].to_s)
  #   response = {}
  #   response['verb'] = 'GET'
  #   response['route'] = ''
  #   response['status'] = 'OK'
  #   response['applications'] = json['applications']
  #   response['header'] = json['header']
  #   response['projects'] = json['projects']
  #   response['bundles'] = json['bundles']
  #   response['marketplaceValues'] = json['marketplace_values']
  #   response[params[:id].to_s] = json[params[:id].to_s]
  #   response['solutions'] = json['solutions']
  #   response['html'] = json['html']
  #   render json: response.to_json
  # end
end
