class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  end

  private

  def customer_access
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def admin_access
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end
end
