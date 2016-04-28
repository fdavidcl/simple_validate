require "simple_validate/version"

module SimpleValidate
  def self.included(klass)
    klass.extend ClassMethods
  end

  def valid?
    self.class.validate(self)
  end

  def invalid?
    !valid?
  end

  def errors
    @errors ||= Errors.new
  end

  module ClassMethods
    def validates_format_of(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      args.each do |attr|
        validations << FormatValidator.new(attr, options)
      end
    end

    def validates_presence_of(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      args.each do |attr|
        validations << PresenceValidator.new(attr, options[:message] || "can't be empty")
      end
    end

    def validations
      @validations ||= []
    end

    def validate(instance)
      validations.each do |validation|
        unless validation.valid?(instance)
          instance.errors.add(validation.attribute, validation.message)
        end
      end
      instance.errors.empty?
    end
  end

  class PresenceValidator
    attr_reader :message
    attr_accessor :attribute

    def initialize(attribute, message)
      @message = message
      @attribute = attribute
    end

    def valid?(instance)
      !instance.send(attribute).nil?
    end
  end

  class FormatValidator
    attr_reader :message
    attr_accessor :attribute

    def initialize(attribute, options)
      @regex     = options[:with]
      @message   = options[:message] || "is incorrect format"
      @attribute = attribute
    end

    def valid?(instance)
      !!(instance.send(attribute) =~ @regex)
    end
  end

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
