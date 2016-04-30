module SimpleValidate
  class ValidatesFormatOf
    attr_reader :message
    attr_accessor :attribute

    def initialize(attribute, options)
      @regex     = options[:with]
      @message   = options[:message] || 'is incorrect format'
      @attribute = attribute
    end

    def valid?(instance)
      !!(instance.send(attribute) =~ @regex)
    end
  end
end
