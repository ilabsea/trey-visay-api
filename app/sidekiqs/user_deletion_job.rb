# frozen_string_literal: true

class UserDeletionJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.with_deleted.find(user_id)
    user.really_destroy!
  end
end
