require 'simple_validate/version'
require 'simple_validate/validates_presence_of'
require 'simple_validate/validates_format_of'
require 'simple_validate/validates_numericality_of'
require 'simple_validate/errors'
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
end
