Trestle.resource(:comments) do
  menu do
    item :comments, icon: "fa fa-comments"
  end

  # Add authorization
  scope :all, -> { current_user.admin? ? Comment.all : Comment.none }

  # Customize the form
  form do |comment|
    select :user_id, options: User.pluck(:name, :id), include_blank: "Select User"
    select :post_id, options: Post.pluck(:title, :id), include_blank: "Select Post" 
    text_area :content
  end
end