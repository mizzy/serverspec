require 'multi_json'

module Serverspec::Type
  class JsonFile < File
    def content
      MultiJson.load(super)
    end
  end
end
