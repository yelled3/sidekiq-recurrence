module Sidekiq
  module Recurrence
    module ClassTracker
      def self.included(base)
        @classes ||= []
        @classes << base.name
      end

      def self.classes
        @classes
      end
    end
  end
end