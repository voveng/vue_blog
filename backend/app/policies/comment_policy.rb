class CommentPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    user&.admin? || record.user == user
  end

  def destroy?
    user&.admin? || record.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end