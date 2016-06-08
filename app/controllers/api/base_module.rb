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

    def serializer(klass)
      "#{controller_module}::#{klass.name}Serializer".constantize
    rescue => e
      fail("There is no serializer for #{klass.name}: #{e}")
    end

    # object or relation
    def serialize(object, options = serialize_params)
      if object.kind_of?(ActiveRecord::Base) || object.kind_of?(Hash)
        serializer(options[:class] || object.class).new(current_user, object, options)
      else
        serializer(options[:class] || object.klass).collection(current_user, object, options)
      end
    end

    def serialize_params
      params.slice(:select, :limit, :offset, :order, :query, :nested).tap do |arr|
        nested = arr[:nested].kind_of?(Hash) ? arr[:nested] : {}
        arr[:nested] = nested.map{|key, value| [key, value.kind_of?(Hash) ? value.slice(:select, :limit, :offset, :order, :query, :nested) : {}]}.to_h
      end
    end

    module ClassMethods
      def class_methods
      end
    end

  end
end
