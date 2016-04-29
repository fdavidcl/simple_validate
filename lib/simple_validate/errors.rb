module SimpleValidate
  class Errors
    def initialize
      @errors = {}
    end

    def add(attribute, message)
      @errors[attribute] = message
    end

    def on(key)
      @errors.fetch(key)
    end

    def empty?
      @errors.empty?
    end
  end
end
