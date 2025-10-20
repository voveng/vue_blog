class FixPostIdSequence < ActiveRecord::Migration[7.0]
  def up
    execute 'CREATE SEQUENCE IF NOT EXISTS posts_id_seq;'

    execute "ALTER TABLE posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq');"

    execute "SELECT setval('posts_id_seq', (SELECT MAX(id) FROM posts));"

    puts 'Post ID sequence has been fixed.'
  end

  def down
    execute 'ALTER TABLE posts ALTER COLUMN id SET DEFAULT NULL;'
    execute 'DROP SEQUENCE IF EXISTS posts_id_seq;'
    puts 'Post ID sequence has been reverted.'
  end
end
