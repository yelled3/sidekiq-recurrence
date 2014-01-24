require 'sidekiq/worker'
require 'sidekiq/recurrence'

class BasicWorker
  include Sidekiq::Worker
  include Sidekiq::Recurrence

  recurrence 1.day
  recurrence [1.day, :at => '4:30 am']

  def perform
    # do stuff ...
  end

end