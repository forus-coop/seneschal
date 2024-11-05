# frozen_string_literal: true

require_relative "seneschal/version"

module Seneschal
  class Error < StandardError; end
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def state_workflow(&block)
      @state_workflow ||= Seneschal::Workflow.new
      @state_workflow.setup &block if block_given?
    end
  end

  module InstanceMethods
    def current_state
      @current_state
    end

    def current_state=(new_state)
      @current_state = new_state
    end

    def method_missing(method, *args)
      if @state_workflow.respond_to?(method)
        @state_workflow.send(method, *args)
      else
        super
      end
    end
  end
end
