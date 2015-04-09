class ServicesController < ApplicationController
  after_action :verify_authorized

  api :GET, '/services', 'Returns a collection of services'
  def index
    authorize Service.new
    load_services
    render json: @services
  end

  api :GET, '/services/:tag', 'Returns services with :tag'
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
    # GET PROJECTS SCOPED TO USER AND GET TAGGED ORDER ITEMS (SERVICES)
    projects = policy_scope(Project)
    @services = []
    projects.each do |project|
      OrderItem.where(project_id: project.id).each do |order_item|
        @services << order_item if order_item.tag_list.include? params[:tag]
      end
    end
  end
end
