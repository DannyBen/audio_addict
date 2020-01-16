module AudioAddict
  module AutoProperties
    attr_reader :properties

    def method_missing(method_sym, *args, &block)
      respond_to?(method_sym) ? properties[method_sym.to_s] : super
    end

    def respond_to_missing?(method_sym, _include_private = false)
      properties.has_key?(method_sym.to_s) || super
    end
  end
end
