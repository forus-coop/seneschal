module Seneschal
  class State
    attr_reader :name

    def initialize(name, workflow)
      @name = name
      @workflow = workflow
    end

    def setup(&block)
      instance_eval(&block)
    end

    private

    def self.event(name, to)
      event = Event.new(name, to)
      @workflow.add_event event
    end
  end
end
