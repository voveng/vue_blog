Trestle.resource(:posts) do
  menu do
    item :posts, icon: "fa fa-file-text"
  end

  # Add authorization
  scope :all, -> { current_user.admin? ? Post.all : Post.none }

  # Customize the form
  form do |post|
    text_field :title
    text_area :body
    select :status, options: Post.statuses.keys
    select :user_id, options: User.pluck(:name, :id), include_blank: "Select Author"
  end
end