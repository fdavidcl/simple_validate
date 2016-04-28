require "simple_validate/version"
require "simple_validate/core_ext/array"

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
      add_validations(args, FormatValidator)
    end

    def validates_presence_of(*args)
      add_validations(args, PresenceValidator)
    end

    def add_validations(args, klass)
      options = args.extract_options!
      args.each do |attr|
        validations << klass.new(attr, options)
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

    def initialize(attribute, options)
      @message = options[:message] || "can't be empty"
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
