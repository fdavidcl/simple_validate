require "simple_validate/version"
require 'active_support/all'

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

  class ValidatesFormatOf
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

  module ClassMethods

    def method_missing(method, *args, &block)
      if "#{method}" =~ /(validates_(format_of|presence_of|numericality_of))/
        add_validations(args, const_get($1.classify))
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      "#{method}" =~ /validates_(format_of|presence_of|numericality_of)/ || super
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
