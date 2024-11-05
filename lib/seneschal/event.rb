module Seneschal
  class Event
    attr_reader :name, :to

    def initialize(name, :to)
      @name = name
      @to = to
    end
  end
end
