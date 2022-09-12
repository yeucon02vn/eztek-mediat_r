# Eztek MediatR

<a href="https://www.buymeacoffee.com/phunguyen" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/eztek/mediat_r`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eztek-mediat_r'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install eztek-mediat_r

## Usage
### Initialize mediatR
Add new file config/initializers/mediat_r.rb to initializer mediatR
```ruby
require 'ez/mediat_r'

Rails.configuration.to_prepare do
    Rails.configuration.mediator = EZ::MediatR.new
    Rails.configuration.mediator.tap do |mediator|
        # Register command - handler
        mediator.register(Auth::Commands::LoginCommand, Auth::Commands::Handlers::LoginCommandHandler.new)
    end
end

```

### Register mediaR in container with dry-container, dry-auto_inject
Use file dependency.rb to register mediatR
```ruby
require 'ez/mediat_r'

dependency_container = Dry::Container.new
dependency_container.register('mediator', -> { Rails.configuration.mediator })
AutoInject = Dry::AutoInject(dependency_container)

```

### Define mediatR in controller
```ruby
include AutoInject['mediator']

```

### Run mediator
```ruby
command = Auth::Commands::LoginCommand.new(username, password)
mediator.execute(command) 

```

## Generator structure with rails 
```ruby
    $ rails generate command feature command_name
```
Example: 
```ruby
    $ rails generate command auth login
```

This will create: 
    app/cqrs/auth/commands/login_command.rb
    app/cqrs/auth/commands/validators/login_command_validator.rb
    app/cqrs/auth/commands/handlers/login_command_handler.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yeucon02vn/eztek-mediat_r.
