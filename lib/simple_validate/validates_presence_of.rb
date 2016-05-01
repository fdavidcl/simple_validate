module SimpleValidate
  class ValidatesPresenceOf < ValidatesBase

    def initialize(attribute, options)
      super(attribute, options[:message] || "can't be empty")
    end

    def valid?(instance)
      !instance.send(attribute).nil?
    end
  end
end
