class RestModel
  class Property
    module Sender
      def to_source!(value, resource, options = {})
        source_value = begin
          translation.translate_to_source(serializer.desserialize(value), resource)
        rescue => exception
          raise exception if options[:fail]
        end

        source = {}
        path = source_path

        if path.any?
          last = path.pop
          key_source = path.inject(source) {|buffer, key| buffer[key] = {}; buffer[key]}
          key_source[last] = source_value
        else
          source.merge!(source_value)
        end

        source
      end
    end
  end
end
