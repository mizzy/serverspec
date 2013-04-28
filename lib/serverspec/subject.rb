module Serverspec
  class Subject
    def value v=nil
      if v.nil?
        @value
      else
        @value = v
        self
      end
    end
  end
end
