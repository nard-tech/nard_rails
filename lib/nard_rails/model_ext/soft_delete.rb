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

  def assign_deleted_date( t = nil, &block )
    if deleted_at.blank?
      t ||= Time.now
      assign_attributes(deleted_at: t )
      if block_given?
        yield(t)
      end
    end
  end

  def remove_deleted_date( &block )
    assign_attributes(deleted_at: nil)
    if block_given?
      yield
    end
  end

end
