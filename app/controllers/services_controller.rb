class ServicesController < ApplicationController
  before_action :load_services, only: [:index]
  after_action :verify_authorized

  api :GET, '/services', 'Returns a collection of services'
  def index
    authorize Service.new
    render json: @services
  end

  private

  def load_services
    # TODO: FILTER TO ONLY USER SERVICES, NOT ALL SERVICES
    @services = policy_scope(Service)
  end
end
