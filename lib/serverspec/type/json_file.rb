require 'json'

module Serverspec::Type
  class JsonFile < File
    def content
      JSON.parse(super)
    end
  end
end
