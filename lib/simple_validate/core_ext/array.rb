module SimpleValidate
  module CoreExt
    module Array
      def extract_options!
        self.last.is_a?(Hash) ? self.pop : {}
      end
    end
  end
end
Array.__send__(:include, SimpleValidate::CoreExt::Array)
