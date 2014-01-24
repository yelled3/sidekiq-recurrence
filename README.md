# Sidekiq::Recurrence

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-recurrence'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-recurrence


```sh
$ cd /apps/my-great-project
$ wheneverize .
```

## Usage

''' ruby
require 'sidekiq/worker'
require 'sidekiq/recurrence'

class BasicWorker
  include Sidekiq::Worker
  include Sidekiq::Recurrence

  recurrence 1.day
  # OR
  recurrence [1.day, :at => '4:30 am']

  def perform
    # do stuff ...
  end

end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/sidekiq-recurrence/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
