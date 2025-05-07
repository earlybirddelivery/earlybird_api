class ManualNotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    %i[fcm_topic_id title message notification_poster click_action]
  end

  def create?
    admin_access
  end

  def index?
    admin_access
  end

  def publish_notification?
    admin_access
  end

  def update?
    admin_access
  end

  def show?
    admin_access
  end

  def destroy?
    admin_access
  end
end
