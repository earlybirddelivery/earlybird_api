module SoftDelete
  extend ActiveSupport::Concern

  def destroy
    authorize(record)
    record.update!(deleted_at: Time.zone.now, deleted_by_id: current_user.id)
  end
end