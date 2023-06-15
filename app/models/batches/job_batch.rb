# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id             :string(8)        not null, primary key
#  code           :string(255)
#  total_count    :integer          default(0)
#  valid_count    :integer          default(0)
#  new_count      :integer          default(0)
#  province_count :integer          default(0)
#  reference      :string(255)
#  creator_id     :integer
#  type           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Batches::JobBatch < Batch
  def self.policy_class
    JobBatchPolicy
  end
end
