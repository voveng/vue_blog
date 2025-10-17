Trestle.resource(:account, model: User, scope: Auth, singular: true) do
  instance do
    current_user
  end

  remove_action :new, :edit, :destroy

  form do |user|
    text_field :email
    text_field :name
    password_field :password, required: false, placeholder: "Leave blank to keep current password"
    password_field :password_confirmation, required: false
  end

  # Limit the parameters that are permitted to be updated by the user
  params do |params|
    params.require(:account).permit(:email, :name, :password, :password_confirmation)
  end
end
