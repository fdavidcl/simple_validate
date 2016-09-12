module SimpleValidate
  class ValidatesBase
    attr_accessor :message, :attribute

    def initialize(attribute, message)
      self.message   = message
      self.attribute = attribute
    end
  end
end
