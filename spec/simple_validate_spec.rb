require 'spec_helper'

RSpec.describe SimpleValidate do

  describe 'no presence when validated' do
    it 'valid? returns false' do
      klass = Class.new
      klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_presence_of :name
      end
      expect(klass.new.valid?).to be(false)
    end


    it "it contains errors" do
      klass = Class.new
      klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_presence_of :name
      end
      instance = klass.new
      instance.valid?
      expect(instance.errors.on(:name)).to eq("can't be empty")
    end
  end


  describe 'invalid format when validated' do
    it "given invalid format when object is validated then valid returns false" do
      klass = Class.new
      klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_format_of :name, :with=>/.+/
      end

      expect(klass.new.valid?).to be(false)
    end
  end
end
