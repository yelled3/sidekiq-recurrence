require 'recurrence/class_tracker'

module Sidekiq
  module Recurrence
    module Runner

      def run_sidekiq_workers
        all_workers.each do |worker_klass|
          run_worker(worker_klass)
        end
      end

      private

      # Runns:
      # every :sunday, :at => '12pm' do
      #   runner "MyWorker.preform_async"
      # end
      def run_worker(worker_klass)
        frequency, options = worker_klass.recurrence
        every frequency, options do
          runner worker_klass.job_name
        end
      end

      # Returns an Array of workers including Sidekiq::Recurrence.
      def all_workers
        Sidekiq::Recurrence.classes
      end

    end
  end
end


module Whenever
  class JobList
    extend Sidekiq::Recurrence::Runner
  end
end


module Sidekiq
  module Recurrence
    extend ClassTracker

    module ClassMethods
      include ClassTracker

      # get from worker class
      def frequency
        return :sunday, :at => '12pm'
      end

      def job_name
        "#{self.class}.perform_async"
      end

    end

  end
end
