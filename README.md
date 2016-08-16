# SpontaneousPrawn

Native PDF generation for Spontaneous CMS.

Adds a new `.prawn` template type that consists of ruby code evaluated as a
template.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spontaneous_prawn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spontaneous_prawn

## Usage

In your spontaneous schema, add a `:pdf` output to the relevant page types

```ruby
class Page < Content::Page
  add_output :pdf, config: { ... }
end
```

Where `config` is a hash of valid Prawn::Document configuration parameters (see
[prawn/document.rb]).

Then add the required templates, e.g. `templates/layouts/page.pdf.prawn`:

```ruby
# templates/layouts/page.pdf.prawn
pdf.text title

```

The template is evaluated in the context of the currently rendered content (as
per text/html templates). PDF layout commands are run on a `pdf` instance that
is a special spontaneous-aware proxy to `Prawn::Document` that translates
content objects into the right format (e.g. string fields -> strings)

See the prawn documentation for usage and commands available on the `pdf`
object.

[prawn/document.rb]: https://github.com/prawnpdf/prawn/blob/master/lib/prawn/document.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### DB Setup

In order to test, you need a sqlite db in `db`. Create using the sequel command line tool.

    bundle exec sequel -m $(bundle show spontaneous)/db/migrations sqlite://db/development.sqlite3


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spontaneous_prawn.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

