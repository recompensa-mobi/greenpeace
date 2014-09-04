module Greenpeace::Configuration
  class Key
    def initialize(key)
      @key = validate_key(key)
    end

    def ==(other)
      other.raw_key == raw_key
    end

    def to_s
      @key.to_s
    end

    def identifier
      @key.to_s
    end

    def env_identifier
      @key.to_s.upcase
    end

    protected
    def raw_key
      @key
    end

    private
    def validate_key(key)
      raise "Key cannot be nil" if key.nil?
      raise "Key #{key} must be a symbol, but was a #{key.class}" unless key.is_a? Symbol
      raise "Key cannot be blank" if key.empty?
      key
    end
  end
end
