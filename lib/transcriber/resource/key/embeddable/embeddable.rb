class Transcriber::Resource
  class Embeddable < Key
    autoload :Parser,   'transcriber/resource/key/embeddable/parser'
    autoload :Resource, 'transcriber/resource/key/embeddable/resource'
    include   Parser
    include   Resource

    attr_reader :many

    def initialize(name, options = {})
      super
      @many           = options.fetch(:many, false)
      @class_name     = options.fetch(:class_name, default_class_name).to_s.camelize
    end

    def one?
      !@many
    end

    def many?
      @many
    end
  end
end