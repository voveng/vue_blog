# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build :post }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end