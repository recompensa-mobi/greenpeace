# Greenpeace

**Greenpeace** is a small environment checker for [12 factor
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
environment checker that checks that the environment contains all the required
values. It also exposes ENV values through a simple configuration API so you
can do `Greenpeace.env.port` instead of `ENV['PORT'].to_i`, applying
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

### Usage

You need to setup your environment in a ruby file of your liking. If you are
using rails, the gem automatically loads a file at `config/greenpeace.rb` where
you should configure your requirements using the provided API. Otherwise, put
those requirements somewhere and ensure they are run before starting your
application.

The API is declarative and quite simple to read and write:

~~~ruby
Greenpeace.configure do |env|
  # You can mark a key to be required for boot.
  env.requires :database_url

  # You can mark a key as an optional value, with a default if it is not
  # defined.
  env.may_have :google_analytics_account, default: "UA-xxxxx"

  # You can mark required or optional keys to be converted to a type when
  # reading the values. Valid types are :string and :int
  env.requires :port, type: :int
  env.may_have :api_timeout, type: :int, default: 30

  # You can add an optional message which describes what the key is about, for
  # documenting configuration options. This documentation string is used when
  # raising an initialization exception if the key is not found, or if the
  # type is not correct.
  env.requires 'API_KEY', doc: "API key for the Frumboloizer service"
end
~~~

Whenever the `configure` method is called (which is done automatically on
rails), Greenpeace will check the environment and raise exceptions if something
is not correctly configured. In addition to this, you can now access the
configured keys through a simple API:

~~~ruby
  if Greenpeace.env.use_google_analytics
    # ...
  end
~~~

## Development

### Prerequisites

The environment is virtualized with vagrant, so you will need:

1. [Vagrant](http://www.vagrantup.com/) to manage the virtualized development
   environment. This requires installing
[VirtualBox](https://www.virtualbox.org/).

1. A [NFS](http://en.wikipedia.org/wiki/Network_File_System) implementation is
   recommended (but not required) so that vagrant works faster. On any
debian-based linux distribution, you can install it by running `sudo apt-get
install nfs-kernel-server `. MacOS comes with it by default.

### Quick environment setup

1. Start the virtualized environment with `vagrant up`. This **will** take a
   while, as the entire development environment is downloaded and configured.

1. Connect to the virtual machine by running `vagrant ssh`. Once connected, `cd
   /vagrant` will cd into the project folder, which is automatically synced to
your machine. There you can run any of the normal ruby commands for gem
development.

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

