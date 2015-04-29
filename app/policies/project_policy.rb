class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def show?
    admin_or_related
  end

  def new?
    # TODO: Can anyone create a new project
    true
  end

  def update?
    admin_or_related
  end

  def destroy?
    admin_or_related
  end

  def approvals?
    true
  end

  def approve?
    user.admin?
  end

  def reject?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.blank?
        scope.none
      elsif user.admin?
        scope
      else
        user.projects
      end
    end
  end

  private

  def admin_or_related
    user.admin? || user.projects.exists?(record.id)
  end
end
