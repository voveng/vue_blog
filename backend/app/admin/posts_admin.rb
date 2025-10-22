Trestle.resource(:posts, model: Post) do
  menu do
    item :posts, icon: 'fa fa-file-text'
  end

  # Add authorization
  scope :all, -> { current_user.admin? ? Post.all : Post.none }
  build_instance do |attrs, _params|
    model.new(attrs).tap do |instance|
      instance.user = current_user
      instance.user_partition = current_user.id % 16
    end
  end

  table do |_post|
    column :Название, ->(post) { post.title }, link: true
    column :Текст, ->(post) { truncate post.body, length: 50 }
    column :Статус, ->(post) { post.status }
    column :Дата, ->(post) { post.created_at }
  end

  form do |_post|
    text_field :title
    text_area :body
    select :status, options: %w[draft published], include_blank: 'Select Status'
  end
end
