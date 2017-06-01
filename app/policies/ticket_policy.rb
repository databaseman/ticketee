class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.project.has_member?(user)
  end

  def create?
    user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
  end

  #The user is an admin.
  #The user is a manager of the project.
  #The user is an editor of the project, and the user is also the author of the ticket.
  def update?
    user.try(:admin?) || record.project.has_manager?(user) || (record.project.has_editor?(user) && record.author == user)
  end

end
