module Posts
  class PostStatus
    include Comparable

    attr_reader :value

    def self.from_string(status_string)
      case status_string.to_sym
      when :draft     then new(:draft)
      when :published then new(:published)
      else raise ArgumentError, "Invalid post status: #{status_string}"
      end
    end

    def draft?
      @value == :draft
    end

    def published?
      @value == :published
    end

    def to_s
      @value.to_s
    end

    def ==(other)
      other.is_a?(self.class) && value == other.value
    end
    alias eql? ==

    def hash
      value.hash
    end

    def initialize(value)
      @value = value
    end
  end
end
