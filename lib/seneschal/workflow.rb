module Seneschal
  class Workflow
    def initialize
      @states = []
      @current_state = nil
      @events = []
    end

    def add_event(event)
      @events << event
    end

    def setup(&block)
      instance_eval(&block)
    end

    def transition(name, &block)
      event = @events.find { |e| e.name == name }
      raise "Invalid transition" unless event
      persist_workflow_state(event.to)
      send("#{event.to}_entered") if respond_to?("#{event.to}_entered")
    end

    def state(name)
      state = State.new(name, self)
      @states << state

      state.setup &block if block_given?

      define_singleton_method("#{name}?") do
        current_state == name
      end
    end

    def add_event(event)
      @events << event
      define_singleton_method("#{event.name}!") do
        transition(event.name)
      end
    end

    def current_state
      @current_state ||= load_workflow_state
    end

    def load_workflow_state
      raise "Not implemented" # to be improved
    end
  
    def persist_workflow_state(new_state)
      raise "Not implemented" # to be improved
    end
  end
end
