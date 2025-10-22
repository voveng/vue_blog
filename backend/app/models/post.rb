# frozen_string_literal: true

require_dependency 'posts/post_status'

class Post < ApplicationRecord
  self.primary_key = 'id'

  scope :recent, -> { order(created_at: :desc) }
  scope :search, ->(query) { where('title ILIKE ? OR body ILIKE ?', "%#{query}%", "%#{query}%") if query.present? }

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :body, presence: true

  # Custom getter for status
  def status
    ::Posts::PostStatus.from_string(read_attribute(:status))
  end

  # Custom setter for status
  def status=(new_status)
    if new_status.is_a?(::Posts::PostStatus)
      write_attribute(:status, new_status.to_s)
    else
      write_attribute(:status, ::Posts::PostStatus.from_string(new_status).to_s)
    end
  end

  def publish
    self.status = ::Posts::PostStatus.from_string(:published)
    save
  end

  def unpublish
    self.status = ::Posts::PostStatus.from_string(:draft)
    save
  end

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= ::Posts::PostStatus.from_string(:draft)
  end
end
