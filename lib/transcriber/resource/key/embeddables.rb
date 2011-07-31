class Transcriber::Resource
  module Embeddables
    def embeds(name, options)
      attr_accessor name
      keys << Embeddable.new(name, options)
    end

    def embeds_one(name, options = {})
      options.merge!(many: false)
      embeds(name, options)
    end

    def embeds_many(name, options = {})
      options.merge!(many: true)
      embeds(name, options)
    end
  end
end