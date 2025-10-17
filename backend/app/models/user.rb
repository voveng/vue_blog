# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum role: { user: 'user', admin: 'admin' }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def admin?
    role == 'admin'
  end
  
  def display_name
    "#{name} (#{email})"
  end
  
  # Methods required for Trestle Auth
  def first_name
    name&.split.first || ''
  end
  
  def last_name
    name_parts = name&.split
    name_parts&.length&.>=(2) ? name_parts[1..-1]&.join(' ') : ''
  end
  
  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable
end
