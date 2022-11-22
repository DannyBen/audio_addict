module AudioAddict
  module Inspectable
    def inspect
      keys = inspectable.map { |k| %[@#{k}="#{send k}"] }
      "#<#{self.class} #{keys.join ', '}>"
    end
  end
end
