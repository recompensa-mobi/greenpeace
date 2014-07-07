# Greenpeace

**Greenpeace** is a small environment checker for rails [12 factor
apps](http://12factor.net/config).

## Why?

One of the factors in a [12 factor app](http://12factor.net) is configuration
management. The recommended approach is using environment variables to provide
configuration values to the application.

While the approach works great, we found some limitations and itches with it:

* There is no way to check if the environment has been correctly configured on
  application startup. This delays deployment and configuration errors until
the moment the configuration key is required.

* Accessing configuration values through the ruby `ENV` hash is a bit
  cumbersome, and does not provide typecasting.

There are some gems already out there that solve these, but none of them fixed
them how we wanted them to. See the similarities section bellow.

**Greenpeace** solves this in a simple, straightforward way. It is an
environment checker that runs before initializers and environments have been
run, checking that the environment contains all the required values. It also
exposes ENV values through the native rails config API so you can do
`Rails.config.mandril_api_key` instead of `ENV['MANDRIL_API_KEY']`, applying
typecasting as required.

## Usage

### Installation

Add the gem to your Gemfile:

~~~ruby
gem "greenpeace"
~~~

Run bundle to install the engine:

~~~
> bundle install
~~~

### Using rails

You need to setup your environment requirements by creating and editing a
`config/greenpeace.rb` file. The ruby script uses a simple API to define what
you require in your environment:

~~~ruby
Greenpeace.configure do |env|
  # You can mark a key to be required for boot.
  env.requires 'DATABASE_URL'

  # You can mark a key as an optional value, with a default if it is not
  # defined.
  env.may_have 'USE_GOOGLE_ANALYTICS', default: "false"

  # You can mark required or optional keys to be converted to a type when
  # reading the values. Valid types are :string and :int
  env.requires 'PORT', type: :int
  env.may_have 'API_TIMEOUT', type: :int, default: 30

  # You can add an optional message which describes what the key is about, for
  # documenting configuration options. This documentation string is used when
  # raising and initialization exception if the key is not found, or if the
  # type is not correct.
  env.requires 'API_KEY', doc: "API key for the Frumboloizer service"
end
~~~

Once you configured the environment requirements, the engine will automatically
check the environment on startup and raise exceptions if something is not
correctly configured. In addition to this, you can now access the configured
keys through the rails built-in configuration API:

~~~ruby
  if Rails.config.use_google_analytics
    # ...
  end
~~~

### Using something else

See the previous section to get a general idea on how everything works.

Done? Well, the difference when you are not using rails is that you need to
manually require your `config/greenpeace.rb` file to have the environment
checked and sanitized. For example, you could do something like this:

~~~ruby
  require "greenpeace"
  require "config/greenpeace"
~~~

After that, you can access the configuration options directly on
`Greenpeace.env`. For example:

~~~ruby
  if Greenpeace.env.use_google_analytics
    # ...
  end
~~~

## License

Copyright (C) 2014 Recompensa.mobi


Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

