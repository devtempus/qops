module Api
  module BaseModule
    def self.included(base)
      base.extend(ClassMethods)
    end

    def deprecated
      respond_with({error: 'This version of api is deprecated.', deprecated: true}, {status: 400, location: root_url})
    end

    def controller_module
      self.class.name.match(/^Api::[^:]*/).to_s
    end

    module ClassMethods
      def class_methods
      end
    end

  end
end
