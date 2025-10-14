# frozen_string_literal: true

class Post < ApplicationRecord
  self.primary_key = 'id'
  
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :body, presence: true
end
