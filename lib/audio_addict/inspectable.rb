module AudioAddict
  module Inspectable
    def inspect
      keys = inspectable.map { |k| %Q[@#{k}="#{send k}"] }
      "#<#{self.class} #{keys.join ", "}>"
    end
  end
end
