Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-users'
  end

  # Customize the form
  form do |_user|
    text_field :email
    text_field :role, placeholder: 'admin, moderator, user'
    password_field :password, required: false, placeholder: 'Leave blank to keep current password'
    password_field :password_confirmation, required: false
  end
end
