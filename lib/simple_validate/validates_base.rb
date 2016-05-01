module SimpleValidate
  class ValidatesBase
    attr_reader :message
    attr_accessor :attribute

    def initialize(attribute, message)
      @message   = message
      @attribute = attribute
    end
  end
end
