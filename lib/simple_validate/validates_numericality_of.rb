module SimpleValidate
  class ValidatesNumericalityOf
    attr_reader :message
    attr_accessor :attribute

    def initialize(attribute, options)
      @message = options[:message] || "must be a number"
      @attribute = attribute
    end

    def valid?(instance)
      instance.send(attribute).is_a?(Numeric)
    end
  end
end
