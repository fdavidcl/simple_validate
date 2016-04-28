require 'spec_helper'

RSpec.describe SimpleValidate do

  describe 'when no presence' do
    before(:each) do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_presence_of :name
      end
    end

    it '#valid? returns false' do
      expect(@klass.new.valid?).to be(false)
    end

    it '#invalid? returns true' do
      expect(@klass.new.invalid?).to be(true)
    end

    it "it will contain errors" do
      instance = @klass.new
      instance.valid?
      expect(instance.errors.on(:name)).to eq("can't be empty")
    end
  end

  # describe 'when invalid format' do
  #   it "#valid? returns false" do
  #     klass = Class.new
  #     klass.class_eval do
  #       include SimpleValidate
  #       attr_accessor :name
  #       validates_format_of :name, with: /.+/
  #     end

  #     expect(klass.new.valid?).to be(false)
  #   end

  #   it "it will contain errors" do
  #     klass = Class.new
  #     klass.class_eval do
  #       include SimpleValidate
  #       attr_accessor :name
  #       validates_format_of :name, with: /.+/
  #     end
  #     instance = klass.new
  #     instance.valid?
  #     expect(instance.errors.on(:name)).to eq("is not the right format")
  #   end
  # end
end
