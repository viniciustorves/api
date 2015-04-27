class AffiliationsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    Project.find(params[:project_id]).groups << group
    head :ok
  end

  api :DELETE, '/projects/:project_id/groups/:group_id', 'Remove a user from a group'
  param :project_id, :number, required: true
  param :group_id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    group = Group.find(params[:group_id])
    Project.find(params[:project_id]).groups.delete(group)
    head :ok
  end

  private

  def group_params
    params.permit!.slice(:name, :description, :staff_ids)
  end
end
