# frozen_string_literal: true

class Post < ApplicationRecord
  include AASM

  self.primary_key = 'id'

  scope :recent, -> { order(created_at: :desc) }
  scope :search, ->(query) { where('title ILIKE ? OR body ILIKE ?', "%#{query}%", "%#{query}%") if query.present? }

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :body, presence: true

  aasm column: :status do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: %i[draft published], to: :published
    end
  end
end
