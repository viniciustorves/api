class ServicesController < ApplicationController
  after_action :verify_authorized

  api :GET, '/services', 'Returns a collection of services'
  def index
    authorize Service.new
    load_services
    render json: @services
  end

  api :GET, '/services/:tag', 'Shows services with :tag'
  def show
    authorize Service.new
    load_tagged_services
    render json: @services
  end

  private

  def load_services
    @services = policy_scope(Service)
  end

  def load_tagged_services
    @services = policy_scope(Service)
  end
end
