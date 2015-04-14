class GroupsController < ApplicationController
  def create
    group = Group.create!(group_params)
    respond_with_params(group)
  end

  def index
    groups = Group.all
    respond_with_params groups
  end

  def show
    group = Group.find(params[:id])
    respond_with_params group
  end

  def update
    group = Group.find(params[:id])
    group.update!(group_params)
    respond_with_params(group)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    respond_with_params(group)
  end

  private

  def group_params
    params.permit!.slice(:name, :description, :staff_ids)
  end
end
