module SimpleValidate
  class ValidatesFormatOf < ValidatesBase

    def initialize(attribute, options)
      @regex = options[:with]
      super(attribute, options[:message] || "is incorrect format")
    end

    def valid?(instance)
      !!(instance.send(attribute) =~ @regex)
    end
  end
end
