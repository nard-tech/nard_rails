module Nard::Rails::ModelExt::SoftDelete

  extend ActiveSupport::Concern

  included do
    scope :active, -> {
      where( deleted_at: nil )
    }

    scope :deleted, -> {
      where.not( deleted_at: nil )
    }
  end

  def soft_delete!(options = {})
    assign_deleted_date
    save!
  end

  alias :logical_delete! :soft_delete!

  def soft_delete(options = {})
    soft_delete!(options)
    return true
  rescue
    return false
  end

  alias :logical_delete :soft_delete

  def activate!(options = {})
    remove_deleted_date
    save!
  end

  def activate(options = {})
    activate!(options)
    return true
  rescue
    return false
  end

  def deleted?
    deleted_at.present?
  end

  def not_deleted?
    !( deleted? )
  end

  alias :active? :not_deleted?

  private

  def assign_deleted_date
    if deleted_at.blank?
      assign_attributes(deleted_at: Time.now)
    end
  end

  def remove_deleted_date
    assign_attributes(deleted_at: nil)
  end

end
