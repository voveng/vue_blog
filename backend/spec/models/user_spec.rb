# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
    it { should have_secure_password(:password) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
