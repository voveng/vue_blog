class PartitionPostsByUserId < ActiveRecord::Migration[7.0]
  def up
    puts 'Starting user-based partitioning of posts...'

    add_column :posts, :user_partition, :integer, default: 0 unless column_exists?(:posts, :user_partition)

    execute 'UPDATE posts SET user_partition = (user_id % 16);'

    execute <<-SQL
      CREATE TABLE posts_partitioned_new (
        id BIGSERIAL,
        title VARCHAR(255) NOT NULL,
        body TEXT,
        user_id BIGINT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
        user_partition INTEGER NOT NULL
      ) PARTITION BY HASH (user_partition);
    SQL

    16.times do |i|
      execute <<-SQL
        CREATE TABLE posts_user_partition_#{i} PARTITION OF posts_partitioned_new
        FOR VALUES WITH (MODULUS 16, REMAINDER #{i});
      SQL
    end

    execute 'CREATE INDEX idx_posts_user_id ON posts_partitioned_new (user_id);'
    execute 'CREATE INDEX idx_posts_created_at ON posts_partitioned_new (created_at);'

    puts 'Migrating posts to partitioned table...'
    execute <<-SQL
      INSERT INTO posts_partitioned_new
      SELECT id, title, body, user_id, created_at, updated_at, (user_id % 16) AS user_partition
      FROM posts;
    SQL

    old_count = ActiveRecord::Base.connection.execute('SELECT COUNT(*) FROM posts;').first['count'].to_i
    new_count = ActiveRecord::Base.connection.execute('SELECT COUNT(*) FROM posts_partitioned_new;').first[
          'count'].to_i

    raise "Data migration failed! Old count: #{old_count}, New count: #{new_count}" unless old_count == new_count

    puts "Successfully migrated #{new_count} posts to partitioned table"

    execute "ALTER TABLE posts RENAME TO posts_backup_#{Time.now.to_i};"
    execute 'ALTER TABLE posts_partitioned_new RENAME TO posts;'

    puts 'Partitioned table is now active!'
  end

  def down
    execute 'ALTER TABLE posts RENAME TO posts_partitioned_backup;'
  end
end
