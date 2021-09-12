module Statusable

  extend ActiveSupport::Concern

  included do
    belongs_to :status
  end

  def self.included(base)
    base.scope :created,    -> {base.where(status_id: 1)}
    base.scope :active,     -> {base.where(status_id: 2)}
    base.scope :suspended,  -> {base.where(status_id: 3)}
    base.scope :inactive,   -> {base.where(status_id: 4)}
    base.scope :hidden,     -> {base.where(status_id: 5)}
    base.scope :deleted,    -> {base.where(status_id: 6)}

    base.scope :not_active, -> {base.where.not(status_id: 3)}
  end

  def is_active?
    self.status_id.to_i == 2
  end

  def active_status?
    self.status_id.to_i == 2
  end

  def not_active_status?
    !self.status_id.to_i == 2
  end

  def suspended_status?
    self.status_id.to_i == 3
  end

  def inactive_status?
    self.status_id.to_i == 4
  end

end