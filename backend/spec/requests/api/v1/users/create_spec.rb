# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/sign_up', type: :request do
  let(:params) do
    { user: {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: '123123',
      password_confirmation: '123123'
    } }
  end
  context 'return when there are no errors ' do
    before { post_json '/api/v1/sign_up', params: }

    subject { response }

    it { is_expected.to have_http_status(:created) }

    context 'with json' do
      subject { json }

      it 'returns success' do
        user = User.last

        expect(json['_interaction_result']).to eq(
          {
            'id' => user.id,
            'name' => user.name,
            'email' => user.email,
            'password_digest' => user.password_digest,
            'created_at' => rfc3339(user.created_at),
            'updated_at' => rfc3339(user.updated_at)
          }
        )
      end
    end
  end

  context 'returns errors' do
    subject { response }

    context 'with json' do
      subject { json }

      it 'without name' do
        params[:user][:name] = ''
        post_json('/api/v1/sign_up', params:)

        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'name',
              'messages' => ['Name can\'t be blank']
            }
          ]
        )
      end

      it 'without password' do
        params[:user][:password] = ''
        post_json('/api/v1/sign_up', params:)
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => ["Password can't be blank"]
            }
          ]
        )
      end

      it 'when the password is less than 6 characters' do
        params[:user][:password] = '12345'
        params[:user][:password_confirmation] = '12345'
        post_json('/api/v1/sign_up', params:)

        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => ['Password is too short (minimum is 6 characters)']
            }
          ]
        )
      end

      it 'without password_confirmation' do
        params[:user][:password_confirmation] = '1'
        post_json('/api/v1/sign_up', params:)
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password_confirmation',
              'messages' => ['Password confirmation doesn\'t match Password']
            }
          ]
        )
      end

      it 'when the password is more than 72 characters' do
        params[:user][:password] = '1' * 73
        params[:user][:password_confirmation] = '1' * 73
        post_json('/api/v1/sign_up', params:)
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'password',
              'messages' => ['Password is too long (maximum is 72 characters)']
            }
          ]
        )
      end

      it 'when the email is incorrect' do
        params[:user][:email] = 'asdasd'
        post_json('/api/v1/sign_up', params:)
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'email',
              'messages' => ['Email is invalid']
            }
          ]
        )
      end

      it 'when email is already in use ' do
        user = create :user
        params[:user][:email] = user.email
        post_json('/api/v1/sign_up', params:)
        is_expected.to eq(
          'success' => false,
          'errors' => [
            {
              'key' => 'email',
              'messages' => ['Email has already been taken']
            }
          ]
        )
      end
    end
  end
end
