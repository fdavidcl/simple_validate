module SimpleValidate
  class ValidatesPresenceOf
    attr_reader :message
    attr_accessor :attribute

    def initialize(attribute, options)
      @message = options[:message] || "can't be empty"
      @attribute = attribute
    end

    def valid?(instance)
      !instance.send(attribute).nil?
    end
  end
end
