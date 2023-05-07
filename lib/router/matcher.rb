class Router
  class Matcher
    ROUTE_PATTERN = %r{/(?<resource>\w+)(?:/(?<id>\d+))?}

    def self.match(path)
      new.match(path)
    end

    def match(path)
      if path == '/'
        { resource: 'root' }
      else
        match_data = path == '/' ? match_rooth_path : path.match(ROUTE_PATTERN)
        match_data&.named_captures&.transform_keys(&:to_sym)&.compact
      end
    end
  end
end
