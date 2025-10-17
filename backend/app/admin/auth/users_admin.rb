Trestle.resource(:users, model: User, scope: Auth) do
  menu do
    group :configuration, priority: :last do
      item :users, icon: "fas fa-users"
    end
  end

  table do
    column :email, link: true
    column :name
    column :role
    column :created_at
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |user|
    text_field :email
    text_field :name
    select :role, options: User.roles.keys.map { |key| [key.humanize, key] }
    password_field :password, required: false, placeholder: "Leave blank to keep current password"
    password_field :password_confirmation, required: false
  end
end
